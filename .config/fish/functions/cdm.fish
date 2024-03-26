function cdm 
  set -l dirname $argv[1]
  if [ -n "$dirname" ]
    mkdir $dirname && cd $dirname
  else
    echo "error"
  end
  
end
