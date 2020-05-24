#!/bin/sh

# Copy the matcher to the host system; otherwise "add-matcher" can't find it.
cp /code/codespell-problem-matcher/codespell-matcher.json /github/workflow/codespell-matcher.json
echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/codespell-matcher.json"

# Run codespell. We add 'error/warning' as GitHub Actions ProblemMatcher needs
# the text 'error/warning' to know how to classify it.
# The weird piping is needed because we want to get the exitcode from codespell,
# but there is no other good universal way of doing so.
# e.g. PIPESTATUS and pipestatus only work in bash/zsh respectively.
echo "Running codespell on '${INPUT_PATH}' ..."
exec 5>&1
res=`{ { codespell ${INPUT_PATH}; echo $? 1>&4; } | sed -r 's/: ([^W][0-9][0-9][0-9])/: error: \1/;s/: (W[0-9][0-9][0-9])/: warning: \1/' 1>&5; } 4>&1`
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
