# STOPGAP: move to provisioning (ansible) when ready; the installer should
# write the correct PNPM_HOME for the OS instead of hardcoding the macOS path.
export PNPM_HOME="$HOME/Library/pnpm"
if [ -d "$PNPM_HOME" ]; then
    case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi
