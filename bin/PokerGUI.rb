class PokerGUI

	include GladeGUI

	def window1__destroy(*args)
		Thread.current.kill
	end

	def before_show
		@dealt = false
		@game = Poker
	end

	def start_button__clicked(*args)
		unless @dealt
			start
			@dealt = true
		else
			num_to_deal = @player.hand.cards.length - @cardGUI.held_cards.length
			@dealer.hold(@player, @cardGUI.held_cards)
    		@dealer.deal(@player, num_to_deal)
			render_cards
			render_results(@dealer.win?(@player.hand))
			@dealt = false
		end
	end

	def start
		@builder['start_button'].label = "Deal"
		@player = Player.new(@game)
		@dealer = Dealer.new(@game, @player)
		@dealer.deal_all
		render_cards
	end

	def render_cards
		@builder['hand'].each { |child| child.destroy }
		@cardGUI = CardGUI.new(@builder, @player.hand.cards, @dealt)
		@cardGUI.render
	end

	def render_results(result)
		unless result.nil?
		  message = "#{result.rule.name} [ #{result.rule.score}, #{result.score} ]"
		else
		  message = 'Lose'
		end
		@builder['start_button'].label = message + " [New Game]"
	end

end
