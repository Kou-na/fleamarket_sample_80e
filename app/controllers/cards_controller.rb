class CardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def index
  end

  def new
    card = Card.where(user_id: current_user.id).first
    redirect_to action: "index" if card.present?
  end

  def create
    Payjp.api_key = 'sk_test_baeedef8848cef8ea22f761f'

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      cutomer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: cutomer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def show
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end
