teardown() {
  if ((BATS_ERROR_STATUS));then
    echo "Failed with status $BATS_ERROR_STATUS"
    if [[ "${output}" != "" ]];then
      echo "Output at that time was:"
      echo "$output"
    else
      echo "Output was empty"
    fi
    return $BATS_ERROR_STATUS
  fi
}
