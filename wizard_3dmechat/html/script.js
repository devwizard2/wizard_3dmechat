window.addEventListener("message", function (event) {
    if (event.data.action === "open") {
        const input = document.getElementById("chat-input");
        input.value = "";
        document.getElementById("chat-box").style.display = "block";
        input.focus();
    }
});

function closeChat() {
    document.getElementById("chat-box").style.display = "none";
    fetch(`https://${GetParentResourceName()}/close`, {
        method: "POST",
    });
}

document.addEventListener("DOMContentLoaded", () => {
    const input = document.getElementById("chat-input");

    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
            closeChat();
        }

        if (e.key === "Enter" && document.getElementById("chat-box").style.display === "block") {
            const message = input.value.trim();
            if (message !== "") {
                fetch(`https://${GetParentResourceName()}/chatCommand`, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ message }),
                });
            }
            closeChat();
        }
    });
});
