# Run this script to install the minimum required Python modules
# to get Power BI Python integration working correctly
#
# This requires Python to be installed first before running
# https://chocolatey.org/packages/python2

Write-Output "Setting the Python encoding to UTF-8"
$env:PYTHONIOENCODING = "UTF-8"
Write-Output ""

Write-Output "Ensuring PIP is installed"
python -m ensurepip
Write-Output ""

Write-Output "Upgrading PIP installer"
python -m pip install --upgrade pip
Write-Output ""

Write-Output "Installing Pandas module"
pip install pandas
Write-Output ""

Write-Output "Installing matplotlib module"
pip install matplotlib
Write-Output ""