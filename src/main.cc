#include "SFML/Graphics.hpp"

int main() {
    sf::RenderWindow window(sf::VideoMode(600, 360), "Hello World SFML Window");

    sf::Font font;
    
    //You need to pass the font file location
    if (!font.loadFromFile("./resources/Roboto-Black.ttf")) {
        return -1;
    }
    sf::Text message("Hello, World !", font);

    while (window.isOpen()) {

        sf::Event e;
        while (window.pollEvent(e)) {

            switch (e.type) {
            case sf::Event::EventType::Closed:
                window.close();
                break;
            }
        }

        window.clear();
        window.draw(message);
        window.display();
    }
    return 0;
}