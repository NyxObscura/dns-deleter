# Cloudflare DNS Purge Script
This Bash script provides a simple way to delete all DNS records within specified Cloudflare zones. It's designed for situations where you need to quickly clear out DNS configurations, such as when decommissioning a domain or performing a complete DNS reset.
# ⚠️ WARNING: EXTREME CAUTION ADVISED


This script will permanently delete ALL DNS records for the zones listed in your zones.json file. This action cannot be undone. Please ensure you have backups or are absolutely certain about proceeding before running this script.
Prerequisites
Before running this script, ensure you have the following installed on your system:
 * jq: A lightweight and flexible command-line JSON processor.
   * Installation (Debian/Ubuntu): sudo apt install jq
   * Installation (macOS via Homebrew): brew install jq
 * curl: A command-line tool for transferring data with URLs. (Usually pre-installed on most Linux/macOS systems).
 
Setup
 * Save the Script: Save the provided script content into a file named purge_cloudflare_dns.sh (or any other .sh name).
 * Make Executable: Grant executable permissions to the script:
   chmod +x purge_cloudflare_dns.sh

 * Create zones.json: In the same directory as your script, create a file named zones.json. This file will contain the Cloudflare Zone IDs and API Tokens for the domains you wish to manage.
zones.json Format

The zones.json file should be a JSON object where each key is a domain name you want to process, and its value is an object containing the zone ID and the apitoken for that specific Cloudflare zone.
{
  "yourdomain1.com": {
    "zone": "YOUR_ZONE_ID_FOR_DOMAIN1",
    "apitoken": "YOUR_API_TOKEN_FOR_DOMAIN1"
  },
  "yourdomain2.net": {
    "zone": "YOUR_ZONE_ID_FOR_DOMAIN2",
    "apitoken": "YOUR_API_TOKEN_FOR_DOMAIN2"
  },
  "another-domain.org": {
    "zone": "YOUR_ZONE_ID_FOR_ANOTHER_DOMAIN",
    "apitoken": "YOUR_API_TOKEN_FOR_ANOTHER_DOMAIN"
  }
}

 * YOUR_ZONE_ID_FOR_DOMAIN: You can find this in your Cloudflare dashboard under the "Overview" tab for your domain.
 * YOUR_API_TOKEN_FOR_DOMAIN: It is highly recommended to create specific API Tokens with "Zone > DNS > Edit" permissions for each zone you want to manage. Do not use your Global API Key for this script, as it grants excessive permissions.
Usage
To run the script, navigate to the directory where you saved the script and zones.json in your terminal, then execute:
./purge_cloudflare_dns.sh

The script will first display a stern warning and ask for explicit confirmation (YES) before proceeding with any deletions. It will then iterate through each domain listed in zones.json, fetch all its DNS records, and delete them one by one.
License
This project is open-source and available under the MIT License.
