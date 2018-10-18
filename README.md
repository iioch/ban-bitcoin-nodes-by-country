# ban-bitcoin-nodes-by-country
Ban all connected bitcoin nodes by country 

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

### To view banned IP addresses:

````
bitcoin-cli listbanned
````

### To clear banned IP addresses:

````
bitcoin-cli clearbanned
````
