import pytest
import os
import py_compile
import subprocess

# Test for manage.py
def test_manage_file_syntax():
    """Test that manage.py has no syntax errors."""
    manage_file = 'statuspage/manage.py'
    assert os.path.isfile(manage_file), f"{manage_file} file not found"
    py_compile.compile(manage_file, doraise=True)

# Test for upgrade.sh
def test_upgrade_file_syntax():
    """Test that upgrade.sh has no syntax errors."""
    upgrade_file = 'upgrade.sh'
    assert os.path.isfile(upgrade_file), f"{upgrade_file} file not found"
    py_compile.compile(upgrade_file, doraise=True)

# Test for gunicorn.py
def test_gunicorn_file_syntax():
    """Test that gunicorn.py has no syntax errors."""
    gunicorn_file = 'contrib/gunicorn.py'
    assert os.path.isfile(gunicorn_file), f"{gunicorn_file} file not found"
    py_compile.compile(gunicorn_file, doraise=True)

# Basic sanity check
def test_empty():
    """This test checks if True is indeed True."""
    assert True
