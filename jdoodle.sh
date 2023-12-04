#!/bin/bash

IFS=','
mkdir -p "company_info"
cd company_info
echo "Current directory is : $(pwd)"

echo "Total number of employees is : "
wc -l /uploads/Employees.csv

c=0
while IFS=',' read -r Department; do
  if [ $Department = "IT" ]
   then
    ((c=c+1))
  fi
done < <(cut -d "," -f6 /uploads/Employees.csv )
echo "Number of employees in IT department is : $c , $(date)" > IT_employess_count.txt
cat IT_employess_count.txt

avg=0
len=0
while IFS=',' read -r Age; do
  ((len=len+1))
  ((avg=avg+Age))
done < <(cut -d "," -f2 /uploads/Employees.csv | tail -n +2 )
((avg=avg/(len)))
echo "Average employees age is : $avg , $(date)" > employess_age_average.txt
cat employess_age_average.txt

min=9999
max=-9999
max_num=0
min_num=0
max_name=""
min_name=""
while IFS=',' read -r Salary Department; do
  if [ $Department = "Technology" ]
   then
    if [ $Salary -lt $min ]
     then
      ((min=$Salary))
      ((min_num=min_num+1))
    fi
    if [ $Salary -gt $max ]
     then
      ((max=$Salary))
      ((max_num=max_num+1))
    fi
  fi
done < <(cut -d "," -f5,6 /uploads/Employees.csv | tail -n +2 )
i=0
while IFS=',' read -r Name; do
  if [ $i = $min_num ]
   then
    ((min_name="${Name}"))
  else
    ((i=i+1))
    continue
  fi
  if [ $i = $max_num ]
   then
    ((max_name=$Name))
  else
    ((i=i+1))
    continue
  fi
done < <(cut -d "," -f1 /uploads/Employees.csv | tail -n +2 )
echo "Maximum salary is : $max for : $max_name 
Minimum salary is : $min for : $min_name  , $(date)" > technology_salaries.txt

valid_chars="(^[^0-9_+-.][A-Za-z0-9_+-.]+)@{1}([A-Za-z0-9.-]+)(\.[A-Za-z]+){1,2}$"
emp_name=()
emp_age=()
emp_email=()
emp_salary=()
emp_phonenumber=()
emp_dept=()
emp_countrycode=()
while IFS=',' read -r Name Age PhoneNumber Email Salary Department CountryCode; do
  if [[ $Email =~ $valid_chars ]] ; then
    continue
  else
   emp_name+="    "$Name
   emp_age+="    "$Age
   emp_email+="    "$Email
   emp_salary+="    "$Salary
   emp_phonenumber+="    "$PhoneNumber
   emp_dept+="     "$Department
   emp_countrycode+="    "$CountryCode
  fi
done < <(cut -d "," -f1,2,3,4,5,6,7 /uploads/Employees.csv | tail -n +2 )
echo "Invalid emails are :
${emp_name[@]}
${emp_age[@]}
${emp_email[@]} 
${emp_salary[@]} 
${emp_phonenumber[@]} 
${emp_dept[@]} 
${emp_countrycode[@]} " > employess_invalid_email.txt
cat employess_invalid_email.txt

val_format="^d{3}[-]\d{3}[-]\d{3}$"
emp_name2=()
emp_age2=()
emp_email2=()
emp_salary2=()
emp_phonenumber2=()
emp_dept2=()
emp_countrycode2=()
while IFS=',' read -r Name Age PhoneNumber Email Salary Department CountryCode; do
  if [[ $PhoneNumber =~ $val_format ]] ; then
    continue
  else
   emp_name2+="    "$Name
   emp_age2+="    "$Age
   emp_email2+="    "$Email
   emp_salary2+="    "$Salary
   emp_phonenumber2+="    "$PhoneNumber
   emp_dept2+="     "$Department
   emp_countrycode2+="    "$CountryCode
  fi
done < <(cut -d "," -f1,2,3,4,5,6,7 /uploads/Employees.csv | tail -n +2 )
echo "Invalid phone numbers are :
${emp_name2[@]}
${emp_age2[@]}
${emp_email2[@]} 
${emp_salary2[@]} 
${emp_phonenumber2[@]} 
${emp_dept2[@]} 
${emp_countrycode2[@]} " > employess_invalid_numbers.txt

while IFS=',' read -r f1 f2 f3 f4 f5 f6 f7
do
   f7="+$f7-$f3"
   echo $f7
done < <(cut -d "," -f1,2,3,4,5,6,7 /uploads/Employees.csv | tail -n +2 )

ls -a

