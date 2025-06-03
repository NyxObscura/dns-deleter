#!/bin/bash
# JSON configuration file name
ZONES_FILE="zones.json"
# Cloudflare API URL
CLOUDFLARE_API_URL="https://api.cloudflare.com/client/v4"

# --- ASCII Art ---
read -r -d '' SCRIPT_ART << "EOF"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⠀⠀⣾⡇⢠⣾⡿⠻⣶⡠⣶⣾⣿⡿⠿⠟⠀⢰⣿⠀⠀⠀⠀⣿⣇⠀⠀⠀⠀⣰⡿⠃⢀⣠⣤⣤⣤⡄⠀⢠⣾⡿⠿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⣸⣿⡀⠀⢻⡇⢸⣏⠀⠀⣾⠇⠀⠀⣿⡇⠀⠀⠀⣸⣿⡇⠀⠀⠀⢻⣿⠀⠀⢀⣼⡟⠁⠀⢸⣿⠉⠉⠉⠀⠀⢸⣿⡀⠀⣿⠇⠀⠀⠤⠴⠀⠤⠤⠤⠤⠤⠄⠠⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣇⠀⠀⢠⣿⣿⡇⠀⢹⣇⠘⣿⡄⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⣿⡟⣷⠀⠀⠀⢸⣿⠀⣠⣿⠋⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠈⢿⣧⠀⠀⠀⠀⠀⠀⡀⠀⢀⣀⣀⠀⢀⣀⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡄⠀⣾⡟⣿⡇⠀⢸⣿⠀⠹⣷⡀⠀⠀⠀⠀⢸⣇⠀⠀⢰⣿⠀⣿⡆⠀⠀⢸⣿⣾⣿⣯⠀⠀⠀⠀⠈⣿⡆⠀⠀⠀⠀⠀⠈⢿⣧⠀⠀⠀⠀⢰⢻⡀⢸⣅⣬⠀⢸⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡝⣿⣼⡿⠀⣿⡇⠀⢸⣿⠀⠀⠘⣿⣄⠀⠀⠀⢸⣿⠀⠀⣸⣿⠀⢸⣧⠀⠀⠈⣿⡟⠉⢿⣷⡀⠀⠀⠀⣿⡿⠿⠃⠀⠀⠀⠀⠈⢻⣷⡀⠀⢠⠟⠙⡇⢸⡇⠹⡄⠘⣇⣀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠘⣿⠃⠀⣿⡇⠀⢸⣿⠀⠀⠀⠈⢿⣆⠀⠀⢸⣿⠀⠀⣿⣿⣠⣤⣿⡄⠀⠀⣿⣇⠀⠀⠻⣷⡄⠀⠀⢹⡇⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⣿⡇⠀⢸⣿⠀⢀⣄⠀⠈⣿⡆⠀⠘⣿⠀⢠⣿⠿⠛⠛⢿⣿⠀⠀⢸⣿⠀⠀⠀⠹⣿⣆⠀⢸⣇⠀⠀⠀⠀⢀⣠⣀⠀⠀⢻⣷⠀⠒⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⣿⡇⠀⠈⠋⠀⣿⠁⠀⠀⢸⣿⠀⠀⢿⠀⢸⣿⠀⠀⠀⠀⣿⣇⠀⢸⣿⠀⠀⠀⠀⠙⣿⣧⠸⠿⠿⠿⠟⣼⡿⠛⠛⠁⠀⢨⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⠇⠀⠀⠀⠀⣿⣇⠀⠀⠀⠀⠹⣧⣤⣤⣾⠇⠀⠀⠀⠀⢘⣋⡄⠀⠀⠀⢸⣿⡀⠸⣿⡄⠀⠀⠀⠀⠈⢿⣧⡀⠀⠀⠀⢻⣧⡀⠀⠀⢀⣾⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠻⣶⣶⣤⣤⣤⣶⣴⣦⣤⡀⠀⢸⡟⠀⠀⠀⠀⢀⣈⡻⠏⠀⡄⠀⠀⣧⠀⡏⠀⠀⠀⠀⠀⠀⣿⣧⠀⣿⡇⠀⠀⠀⠀⠀⠀⠻⣷⠀⠀⠀⠀⠙⢿⣶⣾⡿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⡟⣱⠀⠀⠡⠒⠒⠊⠉⢹⠀⠀⠀⠀⣇⣀⣠⣿⠀⢟⠁⠀⠀⠀⠀⠀⠘⣿⠆⠻⠇⠀⠀⠀⠀⣀⣀⣀⣡⣤⣤⣤⣤⣶⣶⣶⣶⣶⣶⣶⣶⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠙⠿⣿⡿⢟⣩⣾⡿⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⣯⠀⠀⢸⠀⠸⠴⠒⢀⣀⣀⣤⣤⣤⣤⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⣙⣠⣤⣴⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣆⢀⠀⠀⠀⠀
⠀⠀⠀⣠⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢀⣀⣬⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠿⠿⠟⠛⠛⠛⠛⠛⠋⠉⠉⣉⣉⣉⣉⡉⠁⠀⠈⠉⠉⠛⣿⣿⣿⣿⣿⡄⣷⡀⠀⠀
⠀⢠⡐⢿⣿⣿⣿⣿⣿⣿⠿⠿⢛⣛⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠛⠉⠉⢉⣉⣀⠀⢠⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣹⣷⡀⠀
⠀⣿⣿⣷⣶⣯⣽⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⣹⣿⣿⠇⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⣿⣿⣧⠀
⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⣉⣉⣉⡉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢰⣿⣿⣿⣿⠟⠉⣩⡈⠙⣿⣿⠃⠰⣿⣿⡿⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⠟⣡⣾⣿⣿⣿⡆
⢸⣿⣿⣿⣿⣿⣿⣿⡟⢁⣴⣿⣿⣿⣿⣿⣆⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⡿⢿⣿⣿⣿⠀⣼⣿⣿⡿⠁⢰⣿⣿⠏⢀⡾⢁⣶⣦⠹⣿⡇⠀⣿⣿⠿⢿⣿⣿⡿⠟⣡⣾⣿⣿⣿⣿⣿⣷
⢸⣿⣿⣿⣿⣿⣿⣿⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⣿⣿⣿⣿⣿⣿⡿⠛⠻⢿⣿⣿⣿⠟⢁⣤⣤⠀⠀⢸⣿⣿⡇⢀⣿⣿⣿⠇⠀⣈⣤⣤⣴⡞⢡⣿⣿⣿⡇⢹⡇⢸⣿⣿⡄⢸⣿⢫⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣼⣿⣿⣿⣿⣿⣿⡇⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⣄⠈⠙⠻⣿⣿⠏⢀⣶⡷⠘⣿⡿⠋⠀⣿⣿⡟⠀⠀⣿⣿⡿⠀⢸⣿⡿⠋⣀⠀⠙⠿⠟⠉⣴⡿⠋⣠⣼⡗⢸⣷⣄⣉⣉⣴⣿⣿⣷⡝⢿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⡀⢸⣿⣿⣿⣿⣿⣿⡟⢹⡿⢃⣾⣿⣿⠃⢠⣿⡿⠀⠼⠛⣡⣾⡿⢁⡀⠈⠛⠋⣠⣶⡀⠈⠉⣠⣦⣀⣁⣤⣾⣿⣷⣦⣤⣶⣿⣿⡇⠸⣿⡿⢃⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿⣿⣿⣿⣿⣿⣿
⢸⣿⣿⣿⣿⣿⣿⡇⠈⣿⣿⣿⣿⣿⡿⠀⠀⢁⣾⣿⣿⣿⠀⡿⠟⢁⡄⠸⢿⠿⠋⣠⣾⣿⣶⣶⣾⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣷⡘⣿⣿⣿⣿⣿⣿
⢸⣿⣿⣿⣿⣿⣿⣿⡄⠈⠻⠿⠿⠛⢀⠞⠀⢸⣿⣿⣿⣿⣀⣠⣴⣿⣷⣤⣤⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠛⠛⠋⠉⠉⠁⠀⠀⠀⠀⢀⣠⣤⣀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⡿
⠀⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣤⣶⡿⢀⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠉⠉⠀⢀⣀⠀⠀⣠⣤⣶⣦⣄⠀⠀⠀⢰⣿⠟⠛⠻⣷⠀⠀⣰⣿⣿⣿⣿⣿⣿⠇
⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠸⠟⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠉⠉⠀⠀⣤⠀⠀⠀⣿⠟⠛⠛⠛⠀⠀⣿⡁⠀⠀⠹⣷⠀⠀⢸⣿⠀⠀⠀⠉⠀⣰⣿⣿⣿⣿⣿⡿⠏⠀
⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠛⠉⣉⣁⠀⠀⠀⢰⣷⠀⠀⠀⠀⣿⡆⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⣰⡿⠀⠀⠀⢿⣇⠀⠀⠀⣰⣿⣿⣿⡿⠟⠋⠀⠀⠀
⠀⠀⠀⠀⠀⠉⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠟⠛⠛⠉⠉⢉⡀⠀⠀⠀⠀⠀⣠⣾⠟⠻⣷⡀⠀⠸⣿⠀⠀⠀⠀⣿⡇⠀⠀⣿⠀⠀⠀⠀⠀⠀⣿⣿⣾⡿⠋⠀⠀⠀⠀⠀⢻⣦⡀⠠⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣠⣌⠉⠀⣀⣀⣄⣠⣄⠀⠀⠀⠀⢠⡿⣷⡀⠀⠀⠀⢀⣿⠃⠀⠀⠙⠁⠀⠈⣿⡄⠀⠀⠀⣿⡇⠀⠀⣿⡆⠀⠀⠀⠀⠀⣹⡏⠹⣷⠀⠀⠀⠀⠀⠀⠀⠻⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠉⠙⠙⢿⡟⠉⠉⠉⠀⠀⣿⡏⠉⠀⠀⠀⠀⠀⠀⣾⠃⢹⣧⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⣿⣧⣀⣀⣠⣿⣧⠀⠀⣿⣿⣶⡶⠀⠀⠀⢸⡇⠀⢻⣇⠀⠀⠀⠀⠀⠀⠀⠹⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⢰⡏⠀⠀⣿⡆⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⣿⡿⠛⠋⠛⢿⣿⠀⠀⢹⡏⠀⠀⠀⠀⠀⢸⣿⠀⠈⣿⡄⠀⠀⠀⢀⣤⡄⠀⢹⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⡗⠀⠀⠀⠀⠀⣹⣧⣀⣀⡀⠀⠀⠀⣿⣇⡀⣀⣸⣿⠀⠀⠘⣿⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⢸⣿⠀⠀⢸⡇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠘⣷⠀⠀⢠⣿⠏⠁⠀⠀⣿⡷⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⣯⠀⠀⠀⠀⠀⢸⣿⠛⠛⠁⠀⠀⢸⣿⠟⠛⠛⠛⣿⡇⠀⠀⣿⡄⠀⠀⠀⣠⡀⠀⣿⣿⠀⠀⠀⠀⣿⠀⠀⢸⡇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠹⣧⠀⠀⢿⡄⠀⠀⣠⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⣾⠏⠀⠀⠀⠀⠸⣿⠀⠀⠹⣷⡀⠀⢠⣿⠃⠀⢹⣿⠀⠀⠀⠀⣿⠀⠀⢸⣷⣤⣤⣤⣦⠀⠸⡿⠀⠀⠀⠀⠙⣷⡀⠈⠻⠷⠾⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⢸⣿⡀⣀⡀⠀⣸⡟⠀⠀⠀⠀⠀⠀⢻⡧⠀⠀⠈⠛⠿⠛⠋⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣦⣄⣀⠀⢀⣀⣤⠄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⠛⠀⠀⠀⠀⠀⠈⠛⠛⠛⠛⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀
EOF

echo "$SCRIPT_ART"
echo ""

error_exit() {
  echo "ERROR: $1" >&2
  exit 1
}

command -v jq >/dev/null 2>&1 || error_exit "jq is not installed. Please install it (example: sudo apt install jq)."

command -v curl >/dev/null 2>&1 || error_exit "curl is not installed. Please install it (example: sudo apt install curl)."

[ -f "$ZONES_FILE" ] || error_exit "The file $ZONES_FILE was not found. Ensure it's in the same directory."

echo "WARNING: This script will delete ALL DNS records for the domains listed in $ZONES_FILE."
echo "This action CANNOT BE UNDONE."
read -p "Are you absolutely sure you want to proceed? (type 'YES' to continue): " CONFIRMATION
if [ "$CONFIRMATION" != "YES" ]; then
  echo "Operation cancelled."
  exit 0
fi
echo "Confirmation received. Starting deletion process..."

DOMAINS=$(jq -r 'keys[]' "$ZONES_FILE")

for DOMAIN in $DOMAINS; do
    echo ""
    echo "====================================="
    echo "  Processing Zone: $DOMAIN"
    echo "====================================="
    ZONE_ID=$(jq -r --arg domain "$DOMAIN" '.[$domain].zone' "$ZONES_FILE")
    API_TOKEN=$(jq -r --arg domain "$DOMAIN" '.[$domain].apitoken' "$ZONES_FILE")

    if [ "$ZONE_ID" == "null" ] || [ "$API_TOKEN" == "null" ] || [ "$API_TOKEN" == "YOUR_TOKEN_HERE" ]; then
        echo "Skipping $DOMAIN: Zone ID or API Token not found/valid."
        continue
    fi
    echo "Zone ID: $ZONE_ID"
    echo "Fetching DNS records list..."

    DNS_RECORDS_RESPONSE=$(curl -s -X GET "$CLOUDFLARE_API_URL/zones/$ZONE_ID/dns_records" \
         -H "Authorization: Bearer $API_TOKEN" \
         -H "Content-Type: application/json")

    SUCCESS=$(echo "$DNS_RECORDS_RESPONSE" | jq -r '.success')
    if [ "$SUCCESS" != "true" ]; then
        echo "Failed to retrieve DNS records for $DOMAIN. Message: $(echo "$DNS_RECORDS_RESPONSE" | jq .)"
        continue
    fi

    RECORD_IDS=$(echo "$DNS_RECORDS_RESPONSE" | jq -r '.result[].id')

    if [ -z "$RECORD_IDS" ]; then
        echo "No DNS records found for $DOMAIN."        echo "-------------------------------------"
        continue
    fi
    echo "Records found. Starting deletion..."

    TOTAL_RECORDS=$(echo "$RECORD_IDS" | wc -l)
    COUNT=0
    for RECORD_ID in $RECORD_IDS; do
        ((COUNT++))
        echo -n "Deleting record $COUNT/$TOTAL_RECORDS (ID: $RECORD_ID)... "
        DELETE_RESPONSE=$(curl -s -X DELETE "$CLOUDFLARE_API_URL/zones/$ZONE_ID/dns_records/$RECORD_ID" \
             -H "Authorization: Bearer $API_TOKEN" \
             -H "Content-Type: application/json")

        DELETE_SUCCESS=$(echo "$DELETE_RESPONSE" | jq -r '.success')
        if [ "$DELETE_SUCCESS" == "true" ]; then
            echo "Success."
        else
            echo "FAILED. Message: $(echo "$DELETE_RESPONSE" | jq .)"
        fi
    done
    echo "Finished processing $DOMAIN."
    echo "====================================="
done
echo ""
echo "✅  All specified zones have been processed."
