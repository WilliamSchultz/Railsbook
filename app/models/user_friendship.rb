class UserFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  attr_accessible :user, :friend, :state

  scope :accepted, -> { where(state: 'accepted') }
  scope :pending,  -> { where(state: 'pending') }

  validates :friend_id, uniqueness: { scope: :user_id }

  after_destroy :destroy_mutual_friendship!

  state_machine :state, :initial => :pending do
    after_transition on: :accept, do: [:update_mutual_friendship!]
    state :requested

    event :accept do
      transition any => :accepted
    end
  end

  def self.request(user1, user2)
    transaction do
      friendship1 = create(user: user1, friend: user2, state: 'pending')
      friendship2 = create(user: user2, friend: user1, state: 'requested')

    
    end
  end

  def send_request_email
   
  end

  def send_acceptance_email
    
  end

  def mutual_friendship
    self.class.where({user_id: friend_id, friend_id: user_id}).first
  end

  # The delete method is used so that no callbacks are called.
  def destroy_mutual_friendship!
    mutual_friendship.delete if mutual_friendship
  end

  def update_mutual_friendship!
    # Grab the mutual_friendship and update the state attribute without calling the state
    # callbacks. We don't want the opposite user to get an email or anything.
    mutual_friendship.update_attribute(:state, 'accepted') if mutual_friendship
  end

end
