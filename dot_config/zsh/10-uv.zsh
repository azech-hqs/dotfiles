# STOPGAP: move to provisioning (ansible) when ready.
# Workaround for uv issue with creating a virtual environment.
# See also: https://github.com/astral-sh/uv/issues/8821
if command -v uv >/dev/null 2>&1; then
    export PATH="$(dirname "$(realpath "$(which python)")"):$PATH"
fi
