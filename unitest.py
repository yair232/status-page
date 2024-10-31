import pytest
import os
import py_compile

def find_python_files(directory="."):
    """Recursively find all .py files in the given directory."""
    python_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".py"):
                python_files.append(os.path.join(root, file))
    return python_files

@pytest.mark.parametrize("file_path", find_python_files())
def test_syntax(file_path):
    """Check each Python file for syntax errors."""
    py_compile.compile(file_path, doraise=True)
