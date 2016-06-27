api_key="p8sg9fnpz5sh859urt92vaanbc6ztmj2"
locale="en_GB"

## Get species
function get_species
{
  local species_json=$1
  if [[ ! -e $species_json ]]
  then
    echo "Getting pet list..."
    local species_url="https://eu.api.battle.net/wow/pet/?locale=$locale&apikey=$api_key"
    wget \
      --no-clobber \
      --output-document=$species_json \
      --quiet \
      $species_url
  else
    echo "List already downloaded. Using it."
  fi
}

function prepare_species
{
  local species_csv=$1
  if [[ ! -e $species_csv ]]
  then
    local species_json="./data/species.json"
    get_species $species_json
    echo "  Building pet list."
    lua pet_species_to_csv.lua $species_json > $species_csv
  else
    echo "  List already built."
  fi
}

set -e
mkdir -p ./data
mkdir -p ./result
species_csv="./result/species.csv"
prepare_species $species_csv

echo "Results in $species_csv."
