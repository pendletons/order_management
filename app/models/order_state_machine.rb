class OrderStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :placed
  state :paid
  state :cancelled

  transition from: :draft, to: [:placed, :cancelled]
  transition from: :placed, to: [:paid, :cancelled]

  guard_transition(from: :draft, to: :placed) do |order, transition|
    !order.line_items.empty?
  end

  guard_transition(to: :cancelled) do |order, transition|
    !order.cancellation_reason.blank?
  end
end
