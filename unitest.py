import pytest
import os
import py_compile

# List of files to check, including only Python files
files_to_check = [
    'statuspage/manage.py',
    'contrib/gunicorn.py'
]

@pytest.mark.parametrize("file_path", files_to_check)
def test_syntax(file_path):
    """Test that each specified Python file has no syntax errors."""
    assert os.path.isfile(file_path), f"{file_path} file not found"
    py_compile.compile(file_path, doraise=True)
