#!/bin/bash
if ! command -v curl &> /dev/null; then
	echo "You need to install curl to run this script."
	exit 0;
fi

if [ $# -ne 2 ]; then
	echo "Enter date in format YY/mm/dd and number of days.";
	exit 0;
fi

if [[ "$1" =~ ^[0-9]{4}/[0-9]{2}/[0-9]{2}$ ]]; then
	echo "date = ${1}.";
	date=$1;
else
	echo Enter correct date: YY/mm/dd.
	exit 0;
fi

if [[ "$2" =~ ^[0-9]+$ ]]; then
	echo "days = ${2}.";
	days=$2
else
	echo Enter correnct number of days: 7 for example.;
	exit 0;
fi
#extract YEAR motn and day to vars
read YY mm dd <<< ${date//[\/ ]/ };
echo "YY=${YY}, mm=${mm}, dd=${dd}.";

LINK="https://radonezh.ru/radio/";
parsed_links=($(curl -L "$LINK$YY/$mm/$dd/" | grep -Po 'http://.+mp3'));
echo ${parsed_links[@]}
