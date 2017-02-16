class VotesController < ApplicationController
  def create
    authorize! :vote, _movie

    _voter.vote(_type)

    # TODO: should Email be some kind of persistent service?
    # send the movie-creator an email about the vote
    Email.new.send_email(_movie_creator, 'vote_received',
                         'movie': _movie)

    redirect_to root_path, notice: 'Vote cast'
  end

  def destroy
    authorize! :vote, _movie

    _voter.unvote
    redirect_to root_path, notice: 'Vote withdrawn'
  end

  private

  def _voter
    VotingBooth.new(current_user, _movie)
  end

  def _type
    case params.require(:t)
    when 'like' then :like
    when 'hate' then :hate
    else raise
    end
  end

  def _movie
    @_movie ||= Movie[params[:movie_id]]
  end

  def _movie_creator
    @_movie_creator = _movie.user
  end
end
