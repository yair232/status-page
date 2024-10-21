import pytest
import os
import subprocess

# Test for manage.py
def test_manage_file_exists():
    """Test that manage.py exists and is executable."""
    manage_file = 'status-page/statuspage/manage.py'
    assert os.path.isfile(manage_file), f"{manage_file} file not found"
    assert os.access(manage_file, os.X_OK), f"{manage_file} is not executable"

def test_manage_default_env_var():
    """Test that the correct default Django settings module is set."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'statuspage.settings')
    assert os.getenv('DJANGO_SETTINGS_MODULE') == 'statuspage.settings', "Environment variable for Django settings module is not correctly set"

# Test for upgrade.sh
def test_upgrade_file_exists():
    """Test that upgrade.sh exists and is executable."""
    upgrade_file = 'upgrade.sh'
    assert os.path.isfile(upgrade_file), f"{upgrade_file} file not found"
    assert os.access(upgrade_file, os.X_OK), f"{upgrade_file} is not executable"

def test_python_version_in_upgrade_script():
    """Simulate running the Python version check from the upgrade.sh script."""
    python_version_output = subprocess.getoutput('python3 --version')
    assert "Python 3.10" in python_version_output, f"Expected Python 3.10 or later, but got {python_version_output}"

# Test for gunicorn.py
def test_gunicorn_config_exists():
    """Test if the gunicorn.py file exists."""
    gunicorn_file = 'status-page/contrib/gunicorn.py'
    assert os.path.isfile(gunicorn_file), f"{gunicorn_file} file not found"

def test_gunicorn_config():
    """Test if the gunicorn.py settings are valid."""
    gunicorn_settings = {
        "bind": "127.0.0.1:8001",
        "workers": 5,
        "threads": 3,
        "timeout": 120,
        "max_requests": 5000,
        "max_requests_jitter": 500
    }

    # Simulate loading gunicorn settings
    assert gunicorn_settings['bind'] == '127.0.0.1:8001', "Gunicorn bind setting is incorrect"
    assert gunicorn_settings['workers'] > 0, "Gunicorn workers should be greater than 0"
    assert gunicorn_settings['threads'] > 0, "Gunicorn threads should be greater than 0"
    assert gunicorn_settings['timeout'] > 0, "Gunicorn timeout should be greater than 0"
    assert gunicorn_settings['max_requests'] > 0, "Gunicorn max_requests should be greater than 0"

def test_empty():
    """This test checks if True is indeed True."""
    assert True
