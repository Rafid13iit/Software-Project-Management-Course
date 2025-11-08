#!/bin/bash
# Quick start script for AI Chatbot

set -e

PORT=${PORT:-5500}
HOST=${HOST:-127.0.0.1}

echo "========================================="
echo "  AI Chatbot"
echo "  Starting local server..."
echo "========================================="
echo ""
echo "📝 Make sure you have configured your API key in config/api.js"
echo ""

# Kill any process already using the port
echo "� Checking if port ${PORT} is already in use..."
if lsof -ti:${PORT} >/dev/null 2>&1; then
	echo "⚠️  Port ${PORT} is busy. Stopping the existing process..."
	# Try fuser first (common on Linux), then lsof/kill fallback
	if command -v fuser >/dev/null 2>&1; then
		fuser -k ${PORT}/tcp || true
	else
		lsof -ti:${PORT} | xargs -r kill -9 || true
	fi
	sleep 1
else
	echo "✅ Port ${PORT} is free."
fi

echo "�🚀 Starting server on http://${HOST}:${PORT}"
echo ""
echo "💡 Open your browser and go to:"
echo "   http://${HOST}:${PORT}/index.html"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start the Python HTTP server
python3 -m http.server ${PORT}
