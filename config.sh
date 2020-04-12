# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    if [ "$PLAT" -ne "i686" ]; then
        pip install "tensorflow<=1.3.0" "keras>=2.0.4"  # additional deps, available only for x64
    fi

    if [[ "$IS_OSX" -eq 0 ]]; then
        pip install annoy python-Levenshtein>=0.10.2 Morfessor==2.0.2a4
    fi

    python -c 'import gensim; print(gensim.__file__, gensim.models.word2vec.FAST_VERSION)'
    pip freeze
    pytest -rfxEXs --durations=20 --disable-warnings --showlocals --reruns 3 --reruns-delay 1 --pyargs gensim
}
