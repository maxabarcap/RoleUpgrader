class JobOffersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_job_offer, only: [:show, :edit, :update, :destroy]
    before_action :check_administrator, only: [:create]

    def index
        @job_offers = JobOffer.all
    end

    def show
    end

    def new
        @job_offer = JobOffer.new
    end

    def create
        @job_offer = JobOffer.new(job_offer_params)

        if @job_offer.save
            redirect_to @job_offer, notice: 'Job offer was successfully created.'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @job_offer.update(job_offer_params)
            redirect_to @job_offer, notice: 'Job offer was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @job_offer.destroy
        redirect_to job_offers_url, notice: 'Job offer was successfully destroyed.'
    end

    private

    def check_administrator
        unless current_user.administrator?
            redirect_to root_path, alert: 'You do not have permission to perform this action.'
        end
    end
    
    def set_job_offer
        @job_offer = JobOffer.find(params[:id])
    end

    def job_offer_params
        params.require(:job_offer).permit(:title, :description)
    end
end
