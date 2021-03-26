defmodule Rocketpay do

  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Accounts.{Deposit, Withdraw, Transaction}

  # Creates an user and it's account with ballance 0.00
  defdelegate create_user(params), to: UserCreate, as: :call

  # Performs a deposit to the given account
  defdelegate deposit(params), to: Deposit, as: :call

  # Performs a withdraw to the given account
  defdelegate withdraw(params), to: Withdraw, as: :call

  # Performs a transaction between two accounts
  defdelegate transaction(params), to: Transaction, as: :call
end
