defmodule Rocketpay do

  # Creates an user and it's account with ballance 0.00
  alias Rocketpay.Users.Create, as: UserCreate
  defdelegate create_user(params), to: UserCreate, as: :call

  # Performs a deposit to the given account
  alias Rocketpay.Accounts.Deposit, as: Deposit
  defdelegate deposit(params), to: Deposit, as: :call

end
