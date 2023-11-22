class DashboardsController < ApplicationController

def show
  @keys = ["name",
          "price",
          "region",
          "domain",
          "description",
          "year",
          "stock_quantity",
          "category",
          "grape_variety",
          "alcohol_level"
          ]
  @bookings = Booking.where(user: current_user)
  # raise
  end
end
