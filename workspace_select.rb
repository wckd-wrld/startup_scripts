#!/usr/bin/ruby

require "curses"

class Menu < Curses::Window
    @menuItems
    @selectedItem
    
    def initialize(menuItems)
        super(Curses.lines / 2 - 1, Curses.cols / 2 - 1, 0, 0)
        @menuItems = Array.new(menuItems)
        @selectedItem = @menuItems[0]
        return self
    end
    
    def start
        self.draw
        self.inputrouter
    end

    def inputrouter
        while true
            index = @menuItems.find_index(@selectedItem)
            case self.getch
            when 'w'
                @selectedItem = @menuItems[index-1]
                self.draw
            when 's' 
                if index + 1 == @menuItems.length then index = -1 end
                @selectedItem = @menuItems[index+1]
                self.draw
            when 'd' 
                self.send(@selectedItem)
            else 
                
            end
        end
    end 
        
    def draw
        self.clear
        for item in @menuItems
            if @selectedItem == item
                self.addstr("> " + item + "\n")
            else
                self.addstr("  " + item + "\n") 
            end
        end
        self.refresh
    end
    def webdev 
        system("st -c WebSt -e ranger &")
        system("st -c WebSt -e ranger &")
        system("firefox &")
        system("krita &")
        system("gitkraken &")
    end
    public :initialize, :start
end 



Curses.init_screen
begin
    menu = Menu.new(['webdev', 'security', 'gamedev', 'clear'])
    menu.start
ensure
	Curses.close_screen
    
end
