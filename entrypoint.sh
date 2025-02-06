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
echo "Skipping '${INPUT_SKIP}'"
if [ "x${INPUT_SKIP}" != "x" ]; then
    command_args="${command_args} --skip ${INPUT_SKIP}"
fi
echo "Builtin dictionaries '${INPUT_BUILTIN}'"
if [ "x${INPUT_BUILTIN}" != "x" ]; then
    command_args="${command_args} --builtin ${INPUT_BUILTIN}"
fi
echo "Ignore words file '${INPUT_IGNORE_WORDS_FILE}'"
if [ "x${INPUT_IGNORE_WORDS_FILE}" != "x" ]; then
    command_args="${command_args} --ignore-words ${INPUT_IGNORE_WORDS_FILE}"
fi
echo "Ignore words list '${INPUT_IGNORE_WORDS_LIST}'"
if [ "x${INPUT_IGNORE_WORDS_LIST}" != "x" ]; then
    command_args="${command_args} --ignore-words-list ${INPUT_IGNORE_WORDS_LIST}"
fi
echo "Ignore URI words list '${INPUT_URI_IGNORE_WORDS_LIST}'"
if [ "x${INPUT_URI_IGNORE_WORDS_LIST}" != "x" ]; then
    command_args="${command_args} --uri-ignore-words-list ${INPUT_URI_IGNORE_WORDS_LIST}"
fi
echo "Regular expression that is used to find words: '${INPUT_SKIP}'"
if [ "x${INPUT_REGEX}" != "x" ]; then
    command_args="${command_args} --regex ${INPUT_REGEX}"
fi
echo "Files or directories to check: '${INPUT_SKIP}'"
if [ "x${INPUT_FILES}" != "x" ]; then
    command_args="${command_args} --regex ${INPUT_FILES}"
fi
echo "Print a number of lines of trailing context: '${INPUT_AFTER_CONTEXT}'"
if [ "x${INPUT_AFTER_CONTEXT}" != "x" ]; then
    command_args="${command_args} --after-context ${INPUT_AFTER_CONTEXT}"
fi
echo "Print a number of lines of leading context: '${INPUT_BEFORE_CONTEXT}'"
if [ "x${INPUT_BEFORE_CONTEXT}" != "x" ]; then
    command_args="${command_args} --before-context ${INPUT_BEFORE_CONTEXT}"
fi
echo "Print a number of lines of surrounding context: '${INPUT_CONTEXT}'"
if [ "x${INPUT_CONTEXT}" != "x" ]; then
    command_args="${command_args} --context ${INPUT_CONTEXT}"
fi
echo "Resulting CLI options ${command_args}"
exec 5>&1
res=`{ { codespell --count ${command_args} ${INPUT_PATH}; echo $? 1>&4; } 1>&5; } 4>&1`
if [ "$res" = "0" ]; then
    echo "Codespell found no problems"
else
    echo "Codespell found one or more problems"
fi

# Remove the matchers, so no other jobs hit them.
echo "::remove-matcher owner=codespell-matcher-default::"
echo "::remove-matcher owner=codespell-matcher-specified::"

# If we are in warn-only mode, return always as if we pass
if [ -n "${INPUT_ONLY_WARN}" ]; then
    exit 0
else
    exit $res
fi
