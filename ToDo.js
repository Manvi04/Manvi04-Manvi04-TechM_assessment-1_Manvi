// Load tasks from localStorage on page load
document.addEventListener("DOMContentLoaded", () => {
    loadTasks();
});

// Function to add a new task
function addTask() {
    let taskInput = document.getElementById("taskInput");
    let taskText = taskInput.value.trim();

    if (taskText === "") return; // Prevent empty tasks

    let taskList = document.getElementById("taskList");

    // Get current time
    let now = new Date();
    let timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

    // Create a new task element
    let li = document.createElement("li");
    li.innerHTML = `
        <span class="task-text" onclick="toggleTask(this)">${taskText}</span> 
        <small class="timestamp">${timeString}</small>
        <button class="edit-btn" onclick="editTask(this)">✏️</button>
        <button class="delete-btn" onclick="deleteTask(this)">❌</button>
    `;

    taskList.appendChild(li);
    saveTasks(); // Save to local storage

    taskInput.value = ""; // Clear input field
}

// Function to toggle task completion
function toggleTask(taskElement) {
    taskElement.parentElement.classList.toggle("completed");
    saveTasks(); // Save updated state
}

// Function to edit a task
function editTask(editButton) {
    let li = editButton.parentElement;
    let span = li.querySelector(".task-text");
    let newTaskText = prompt("Edit your task:", span.innerText);

    if (newTaskText !== null && newTaskText.trim() !== "") {
        span.innerText = newTaskText.trim();
        saveTasks(); // Save updated task
    }
}

// Function to delete a task
function deleteTask(deleteButton) {
    deleteButton.parentElement.remove();
    saveTasks(); // Save after deletion
}

// Function to save tasks to localStorage
function saveTasks() {
    let tasks = [];
    document.querySelectorAll("#taskList li").forEach(li => {
        tasks.push({
            text: li.querySelector(".task-text").innerText,
            completed: li.classList.contains("completed"),
            time: li.querySelector(".timestamp").innerText
        });
    });

    localStorage.setItem("tasks", JSON.stringify(tasks));
}

// Function to load tasks from localStorage
function loadTasks() {
    let tasks = JSON.parse(localStorage.getItem("tasks")) || [];

    let taskList = document.getElementById("taskList");
    taskList.innerHTML = ""; // Clear existing tasks

    tasks.forEach(task => {
        let li = document.createElement("li");
        li.classList.toggle("completed", task.completed);

        li.innerHTML = `
            <span class="task-text" onclick="toggleTask(this)">${task.text}</span> 
            <small class="timestamp">${task.time}</small>
            <button class="edit-btn" onclick="editTask(this)">✏️</button>
            <button class="delete-btn" onclick="deleteTask(this)">❌</button>
        `;

        taskList.appendChild(li);
    });
}
