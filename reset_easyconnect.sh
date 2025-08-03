#!/bin/bash

echo "🔪 Killing EasyConnect processes..."
sudo pkill -f EasyConnect
sudo pkill -f EasyMonitor
sudo pkill -f ECAgent
sudo pkill -f ECAgentProxy

echo "🧹 Flushing DNS..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

echo "🌐 Resetting network interfaces..."
sudo ifconfig en0 down
sleep 1
sudo ifconfig en0 up

echo "✅ EasyConnect environment cleaned. You can now reopen it."

