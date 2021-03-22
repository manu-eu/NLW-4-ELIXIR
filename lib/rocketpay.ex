defmodule Rocketpay do

  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Accounts.{Deposit, Withdraw}

  # Creates an user and it's account with ballance 0.00
  defdelegate create_user(params), to: UserCreate, as: :call

  # Performs a deposit to the given account
  defdelegate deposit(params), to: Deposit, as: :call

  # Performas a withdraw to the given account
  defdelegate withdraw(params), to: Withdraw, as: :call
end
