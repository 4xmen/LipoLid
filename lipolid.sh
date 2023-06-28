#!/bin/bash

install_laravel() {
    clear
    # Install dependencies
    sudo apt-get update
    sudo apt-get install curl php-cli php-mbstring git unzip -y

    # Install Composer
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer

    # Install Laravel
    composer global require laravel/installer
    echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
}

create_laravel_project() {
    clear
    # Prompt for project name
    read -p "Enter project name: " project_name
    read -p "Enter project directory: " project_dir

    cd $project_dir
    # Create Laravel project
    composer create-project --prefer-dist laravel/laravel $project_name
    cd $project_name

    # Start Laravel development server
    php artisan serve
}


create_laravel_project_de() {
    clear
    # Prompt for project name
    read -p "Geben Sie den Projektnamen ein: " project_name
    read -p "Geben Sie das Projektverzeichnis ein: " project_dir


    cd $project_dir
    # Create Laravel project
    composer create-project --prefer-dist laravel/laravel $project_name
    cd $project_name

    # Start Laravel development server
    php artisan serve
}

# Define the logo ASCII art
logo="
 ⠀⠀⠀⠀⣴⣶⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡀⠀
 ⠀⠀⠀⢠⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡟⠀⠀
 ⠀⠀⠀⠀⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⣴⣿⣿⡟⠀⠀⠀
 ⠀⠀⠀⠀⠹⣿⠿⢿⣿⣿⣷⣄⣴⣿⠟⠁⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣅⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠿⢿⣿⣿⣷⡀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⢀⣴⣾⣿⠟⠁⠀⠀⠙⢿⣿⣿⣦⡀⠀⠀⠀
 ⠀⢀⣠⣾⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠻⣿⡿⣿⣆⠀⠀
 ⣰⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣌⠻⣷⡄
 ⢿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀
"

# Define the welcome message
welcome_message="Welcome to the Xstack Laravel Installer!"
welcome_message_de="Willkommen beim Xstack Laravel Installer!"

choose_lang="Select a language:"


# Define the table dimensions
table_width=60
table_height=10

# Define the menu options
option_1="1. Download and Install Laravel Dependencies"
option_2="2. Create Laravel's Project"
option_3="3. Exit"


option_1_de="1. Laden Sie Laravel Abhängigkeiten herunter und installieren Sie es"
option_2_de="2. Erstellen Sie Laravels Projekt"
option_3_de="3. Beenden"

option_lang_1="1. English"
option_lang_2="2. Deutsch"

# Function to print a line
print_line() {
    local line=""
    for ((i=0; i<$table_width; i++)); do
        line+="-"
    done
    echo "$line"
}

# Function to print centered text
print_centered_text() {
    local text=$1
    local text_length=${#text}
    local padding_length=$(( ($table_width - $text_length) / 2 ))
    local padding=""
    for ((i=0; i<$padding_length; i++)); do
        padding+=" "
    done
    echo "$padding$text"
}





# Check if the user is root
if [ "$EUID" -eq 0 ]; then
    clear
    # User is root, call function a()
    print_centered_text "$logo"

    print_line

    print_centered_text "$welcome_message"

    print_line

    print_centered_text "$choose_lang"
    print_centered_text "$option_lang_1"
    print_centered_text "$option_lang_2"
    print_centered_text "$option_3"

    print_line

    read -p "Enter your choice (1-3): " choice_lang
    case $choice_lang in
        1)
            clear
            print_centered_text "$logo"

            print_line

            print_centered_text "$welcome_message"
            print_line

            print_centered_text "$option_1"
            print_centered_text "$option_2"
            print_centered_text "$option_3"

            print_line
            read -p "Enter your choice (1-3): " choice_option
            case $choice_option in
                1)
                    install_laravel
                    ;;
                2)
                    create_laravel_project
                    ;;
                3)
                    exit 0
                    ;;
                *)
                    echo "Invalid input. Please enter a number between 1 and 3."
                    ;;
            esac
            # Perform EN
            ;;
        2)
            clear
            print_centered_text "$logo"

            print_line

            print_centered_text "$welcome_message_de"
            print_line

            print_centered_text "$option_1_de"
            print_centered_text "$option_2_de"
            print_centered_text "$option_3_de"

            print_line
            read -p "Geben Sie Ihre Auswahl ein (1-3):" choice_option
            case $choice_option in
                1)
                    install_laravel
                    ;;
                2)
                    create_laravel_project_de
                    ;;
                3)
                    exit 0
                    ;;
                *)
                    echo "Ungültige Eingabe. Bitte geben Sie eine Zahl zwischen 1 und 3 ein."
                    ;;
            esac
            # Perform DE
            ;;
        3)
            exit 0
            # Perform EXIT
            ;;
        *)
            echo "Invalid choice. Please enter a number from 1 to 3."
            ;;
    esac
else
    # User is not root, print error message
    echo "Error: You must be root to run this script."
fi