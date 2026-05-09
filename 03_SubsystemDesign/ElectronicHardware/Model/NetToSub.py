import re
from pathlib import Path


def extract_net_body(net_path: Path) -> str:
    """
    Extract all lines from .net except .end (case insensitive).
    """
    lines = net_path.read_text(encoding="utf-8").splitlines()

    filtered = []
    for line in lines:
        stripped = line.strip().lower()
        if stripped == ".end":
            continue
        filtered.append(line)

    return "\n".join(filtered)


def replace_subckt_body(sub_path: Path, new_body: str) -> None:
    """
    Replace content between CIRCUIT_BODY_START and CIRCUIT_BODY_END
    with new_body.
    """

    content = sub_path.read_text(encoding="utf-8")

    pattern = re.compile(
        r"(\*\* CIRCUIT_BODY_START \*\*).*?(\*\* CIRCUIT_BODY_END \*\*)",
        re.DOTALL
    )

    replacement = (
        "** CIRCUIT_BODY_START **\n\n"
        + new_body.strip()
        + "\n\n** CIRCUIT_BODY_END **"
    )

    # Use lambda to prevent re.sub from interpreting backslashes
    new_content = re.sub(pattern, lambda m: replacement, content)

    sub_path.write_text(new_content, encoding="utf-8")

def net_to_sub(net_file, sub_file):
    net_path = Path(net_file)
    sub_path = Path(sub_file)

    if not net_path.exists():
        raise FileNotFoundError(f".net file not found: {net_file}")
    if not sub_path.exists():
        raise FileNotFoundError(f".sub file not found: {sub_file}")

    print("Extracting .net body...")
    net_body = extract_net_body(net_path)

    print("Updating .sub file...")
    replace_subckt_body(sub_path, net_body)

    print("✅ Subcircuit updated successfully.")


# =============================
# Example usage
# =============================
if __name__ == "__main__":
    net_to_sub(
        r"AFE.net",
        r"AFE.sub"
    )
