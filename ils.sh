# /usr/bin/env bash

delimiter="_"
ellipses="..."
format="%-35s%-20s%-20s%-20s%-20s%-20s"
max_name_length=30
max_name_char_length=27
max_length=15
max_char_length=12

print_row() {
    IFS='_', read -r -a arr <<< "${1}"

    name="${arr[4]}"
    (( ${#name} > max_name_length )) && name="${name:0:max_name_char_length}${ellipses}"
    date="${arr[5]}"
    (( ${#date} > max_length )) && date="${date:0:max_char_length}${ellipses}"
    project="${arr[2]}"
    (( ${#project} > max_length )) && project="${project:0:max_char_length}${ellipses}"
    type="${arr[3]}"
    (( ${#type} > max_length )) && type="${type:0:max_char_length}${ellipses}"
    org="${arr[1]}"
    (( ${#org} > max_length )) && org="${org:0:max_char_length}${ellipses}"
    namespace="${arr[0]}"
    (( ${#namespace} > max_length )) && namespace="${namespace:0:max_char_length}${ellipses}"

    printf "${format}" "${name}" "${date}" "${project}" "${type}" "${org}" "${namespace}"
    echo "\r"
}

printf "${format}" "Name" "Date" "Project" "Type" "Organization" "Namespace"
echo "\r"

for item in $(ls); do
  if [[ $(echo "${item}" | grep "${delimiter}") ]]; then
    print_row "${item%\.*}"
  fi
done
