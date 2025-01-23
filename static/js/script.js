document.addEventListener('DOMContentLoaded', () => {
    console.log('EduPathWay JavaScript Loaded');

    const username = JSON.parse(document.getElementById('username').textContent);
    const chatSocket = new WebSocket(
        'ws://' + window.location.host + '/ws/chat/' + username + '/'
    );

    chatSocket.onmessage = function(e) {
        const data = JSON.parse(e.data);
        const message = data.message;

        const messagesContainer = document.getElementById('messages');
        const newMessage = document.createElement('div');
        newMessage.innerHTML = `
            <strong>${message.sender}</strong>: ${message.content} <small>${message.timestamp}</small>
        `;
        messagesContainer.appendChild(newMessage);
    };

    chatSocket.onclose = function(e) {
        console.error('Chat socket closed unexpectedly');
    };

});
