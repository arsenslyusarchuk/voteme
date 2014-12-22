module Api::V1
  class PollsController < ApiController
    respond_to :json
    before_action :get_poll, only: [:show, :update, :destroy, :stop]

    has_scope :search
    has_scope :order_by_id

    def index
      render json: apply_scopes(Poll).preload(:answers).paginate(page: params[:page], per_page: params[:per_page])
    end

    def search
      render json: apply_scopes(Poll).paginate(page: params[:page], per_page: params[:per_page])
    end

    def show
      render json: @poll
    end

    def create
      @poll = Poll.new(poll_params)
      @poll.user = current_user
      if @poll.save
        render json: @poll
      else
        render json: @poll.errors
      end
    end

    def update
      current_user.answers << Answer.where(id: params[:answer_ids])
      current_user.save!
      render json: @poll
    end

    def destroy
      authorize! :destroy, @poll
      @poll.destroy
      render json: @poll
    end

    def stop
      authorize! :stop, @poll
      @poll.update_attributes! poll_params
      SendEmailWorker.perform_async(@poll.id)
      render json: @poll
    end

    private

      def get_poll
        @poll ||= Poll.find(params[:id])
      end

      def poll_params
        params.permit(:title, :description, :poll_type, :stopped, answers_attributes: [:title])
      end
  end
end
