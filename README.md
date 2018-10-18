# ban-bitcoin-nodes-by-country
Fed up with one country sucking all ressources out of you node? Has your team just lost against that country? 
Then just ban all connected bitcoin nodes by filtering that country. 

## Requirements for the bash script (ban.sh)

### Command-line JSON processor jq.

Install on Debian-based Linux
```` 
sudo apt-get install jq
```` 
### geoiplookup database and tool

Install on Debian-based Linux
```` 
sudo apt-get install geoip-bin
```` 
## Download and use the script

`git clone https://github.com/iioch/ban-bitcoin-nodes-by-country.git`

Run:

````
cd ban-bitcoin-nodes-by-country   
chmod u+x ban.sh   
./ban.sh
````
Adjust country shortcode in ban.sh to your needs:
````
Shortcode=CN
````

### To view banned IP addresses:

````
bitcoin-cli listbanned
````

### To clear banned IP addresses:

````
bitcoin-cli clearbanned
````
