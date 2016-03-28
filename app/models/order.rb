class Order < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries

  VAT_AMOUNT = 1.20

  has_many :order_transitions, autosave: false
  has_many :line_items
  has_many :products, through: :line_items

  validates_presence_of :order_date, :vat_amount
  validates_numericality_of :vat_amount, greater_than_or_equal_to: 0

  validates :order_date, date: { after_or_equal_to: Proc.new { Date.current } }
  validate :order_is_draft?, on: :update

  before_validation :set_default_order_date, :set_vat_amount

  before_destroy :verify_deletion

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
               to: :state_machine

  def state_machine
    @state_machine ||= OrderStateMachine.new(self)
  end

  def self.initial_state
    :draft
  end
  private_class_method :initial_state

  def net_total
    line_items.inject(0) { |sum, li| sum + li.total }
  end

  def gross_total
    net_total * VAT_AMOUNT
  end

  def can_be_changed?
    current_state == "draft"
  end

  private

    def set_default_order_date
      self[:order_date] ||= Date.current
      self[:order_date] = Date.current if past_order_date?
      nil
    end

    def set_vat_amount
      # cache this in case VAT changes in the future
      self[:vat_amount] ||= VAT_AMOUNT
      nil
    end

    def past_order_date?
      order_date.is_a?(Date) && order_date < Date.current
    end

    def verify_deletion
      false # orders cannot be deleted
    end

    def order_is_draft?
      unless can_be_changed?
        errors[:base] << "Cannot change placed orders."
        return false
      end
    end
end
