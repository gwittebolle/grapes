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
  end
end
