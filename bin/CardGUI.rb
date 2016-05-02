class CardGUI < Gtk::HBox

	WHITE = Gdk::Color.new(65535, 65535, 65535)
	GRAY = Gdk::Color.new(60394, 60394, 60394)
	DGRAY = Gdk::Color.new(57054, 57054, 57054)

	attr_accessor :held_cards

	def initialize(builder, cards, dealt = false)
		super(true)
		@cards = []
		@held_cards = []
		@dealt = dealt
		@builder = builder
		cards.each do |card|
			self.add(card)
		end
	end

	def add(card)	
		@cards << card
		eb = Gtk::EventBox.new
		eb.modify_bg(Gtk::STATE_NORMAL, WHITE)
		eb.border_width = 3

		unless @dealt
			eb.signal_connect("enter_notify_event") do
			  eb.modify_bg(Gtk::STATE_NORMAL, GRAY) unless held?(card)
			end
			eb.signal_connect("leave_notify_event") do
			  eb.modify_bg(Gtk::STATE_NORMAL, WHITE) unless held?(card)
			end
			eb.signal_connect("button_press_event") do
				if held?(card)
					unhold(card)
					eb.modify_bg(Gtk::STATE_NORMAL, WHITE)
				else
					hold(card)
					eb.modify_bg(Gtk::STATE_NORMAL, DGRAY)
				end		  
			end
		end
		c = Gtk::VBox.new(true)
		top_left = build_label("<span foreground=\"#{card.suit.color}\" font_desc='14'>#{card.value.label}\n#{card.suit.label}</span>")
		top_left.set_alignment(0, 0)
		top_left.set_padding(5, 5)
		center = build_label("<span foreground=\"#{card.suit.color}\" font_desc='44'>#{card.suit.label}</span>")
		bottom_right = build_label("<span foreground=\"#{card.suit.color}\" font_desc='14'>#{card.value.label}\n#{card.suit.label}</span>")
		bottom_right.set_alignment(1, 1)
		bottom_right.set_padding(5, 5)
		bottom_right.set_angle(180)
		c.add_child(@builder, top_left)
		c.add_child(@builder, center)
		c.add_child(@builder, bottom_right)
		eb.add_child(@builder, c)
		self.add_child(@builder, eb)
	end

	def build_label(text)
		label = Gtk::Label.new
		label.set_markup(text)
		label
	end

	def render
		@builder['hand'].add_child(@builder, self)
		@builder["window1"].show_all
	end

	def held?(card)
		@held_cards.include?(card)
	end

	def hold(card)
		@held_cards << card unless @held_cards.include?(card)
	end

	def unhold(card)
		@held_cards.delete(card) if @held_cards.include?(card)
	end

end
