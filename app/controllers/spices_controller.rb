class SpicesController < ApplicationController

    def index
        spices = Spice.all
        render json: spices
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: :accepted
    rescue ActiveRecord::RecordNotFound
        render_not_found
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
         render_not_found

    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found
        render json: {error: 'spice not found'}, status: :not_found
    end

    def find_spice
        Spice.find(params[:id])

    end
end
