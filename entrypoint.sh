#!/bin/sh

# Copy the matcher to the host system; otherwise "add-matcher" can't find it.
cp /code/codespell-matcher.json /github/workflow/codespell-matcher.json
echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/codespell-matcher.json"

# Run codespell.
# The weird piping was needed because we want to get the exitcode from codespell,
# but there is no other good universal way of doing so.
# e.g. PIPESTATUS and pipestatus only work in bash/zsh respectively.
echo "Running codespell on '${INPUT_PATH}' with the following options..."
command_args=""
echo "Check filenames? '${INPUT_CHECK_FILENAMES}'"
if [ -n "${INPUT_CHECK_FILENAMES}" ]; then
    echo "Checking filenames"
    command_args="${command_args} --check-filenames"
fi
echo "Check hidden? '${INPUT_CHECK_HIDDEN}'"
if [ -n "${INPUT_CHECK_HIDDEN}" ]; then
    echo "Checking hidden"
    command_args="${command_args} --check-hidden"
fi
echo "Exclude file '${INPUT_EXCLUDE_FILE}'"
if [ "x${INPUT_EXCLUDE_FILE}" != "x" ]; then
    command_args="${command_args} --exclude-file ${INPUT_EXCLUDE_FILE}"
fi
echo "Resulting CLI options ${command_args}"
exec 5>&1
res=`{ { codespell ${command_args} ${INPUT_PATH}; echo $? 1>&4; } 1>&5; } 4>&1`
if [ "$res" = "0" ]; then
    echo "Codespell found no problems"
else
    echo "Codespell found one or more problems"
fi

# Remove the matcher, so no other jobs hit it.
echo "::remove-matcher owner=codespell::"

# If we are in warn-only mode, return always as if we pass
if [ -n "${INPUT_ONLY_WARN}" ]; then
    exit 0
else
    exit $res
fi
