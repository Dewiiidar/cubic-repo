
let getById = (id, parent) => parent ? parent.getElementById(id) : getById(id, document);
let getByClass = (className, parent) => parent ? parent.getElementsByClassName(className) : getByClass(className, document);

const DOM =  {
	chatListArea: getById("chat-list-area"),
	messageArea: getById("message-area"),
	inputArea: getById("input-area"),
	chatList: getById("chat-list"),
	messages: getById("messages"),
	chatListItem: getByClass("chat-list-item"),
	messageAreaName: getById("name", this.messageArea),
	messageAreaPic: getById("pic", this.messageArea),
	messageAreaNavbar: getById("navbar", this.messageArea),
	messageAreaDetails: getById("details", this.messageAreaNavbar),
	messageAreaOverlay: getByClass("overlay", this.messageArea)[0],
	messageInput: getById("input"),
	postedFile: getById("postedFile"),
	profileSettings: getById("profile-settings"),
	profilePic: getById("profile-pic"),
	profilePicInput: getById("profile-pic-input"),
	inputName: getById("input-name"),
	username: getById("username"),
	displayPic: getById("display-pic"),
};

let mClassList = (element) => {
	return {
		add: (className) => {
			element.classList.add(className);
			return mClassList(element);
		},
		remove: (className) => {
			element.classList.remove(className);
			return mClassList(element);
		},
		contains: (className, callback) => {
			if (element.classList.contains(className))
				callback(mClassList(element));
		}
	};
};

// 'areaSwapped' is used to keep track of the swapping
// of the main area between chatListArea and messageArea
// in mobile-view
let areaSwapped = false;

// 'chat' is used to store the current chat
// which is being opened in the message area
let chat = null;

// this will contain all the chats that is to be viewed
// in the chatListArea
let chatList = [];

// this will be used to store the date of the last message
// in the message area
let lastDate = "";


// 'populateChatList' will generate the chat list
// based on the 'messages' in the datastore
let populateChatList = () => {
	chatList = [];

	// 'present' will keep track of the chats
	// that are already included in chatList
	// in short, 'present' is a Map DS
	let present = {};

	MessageUtils.getMessages()
	.sort((a, b) => mDate(a.time).subtract(b.time))
	.forEach((msg) => {
		let chat = {};
		
		chat.isGroup = msg.recvIsGroup;
		chat.msg = msg;

		if (msg.recvIsGroup) {
			chat.group = groupList.find((group) => (group.id === msg.recvId));
			chat.name = chat.group.name;
		} else {
			chat.contact = contactList.find((contact) => (msg.sender !== user.id) ? (contact.id === msg.sender) : (contact.id === msg.recvId));
			chat.name = chat.contact.name;
		}

		chat.unread = (msg.sender !== user.id && msg.status < 2) ? 1: 0;

		if (present[chat.name] !== undefined) {
			chatList[present[chat.name]].msg = msg;
			chatList[present[chat.name]].unread += chat.unread;
		} else {
			present[chat.name] = chatList.length;
			chatList.push(chat);
		}
	});
};



let viewChatList = () => {
	DOM.chatList.innerHTML = "";
	chatList
	.sort((a, b) => mDate(b.msg.time).subtract(a.msg.time))
	.forEach((elem, index) => {
		let statusClass = elem.msg.status < 2 ? "far" : "fas";
		let unreadClass = elem.unread ? "unread" : "";
		
		DOM.chatList.innerHTML += `
		<div class="chat-list-item d-flex flex-row w-100 p-2 border-bottom ${unreadClass}" onclick="generateMessageArea(this, ${index})">
			<img src="Content/Whatsappimages/Ass09123asdj9dk0qw.jpg" alt="Profile Photo" class="img-fluid rounded-circle mr-2" style="height:50px;">
			<div class="w-50">
				<div class="name">${elem.name}</div>
				<div class="small last-message">${elem.isGroup ? contactList.find(contact => contact.id === elem.msg.sender).number + ": " : ""}${elem.msg.sender === user.id ? "<i class=\"" + statusClass + " fa-check-circle mr-1\"></i>" : ""} ${elem.msg.body}</div>
			</div>
			<div class="flex-grow-1 text-right">
				<div class="small time"> </div>
				${elem.unread ? "<div class=\"badge badge-success badge-pill small\" id=\"unread-count\">" + elem.unread + "</div>" : ""}
			</div>
		</div>
		`;
		
	});
};

			let generateChatList = () => {
				
	populateChatList();
	viewChatList();
				
};

let addDateToMessageArea = (date) => {
	DOM.messages.innerHTML += `
	
	`;
};

let addMessageToMessageArea = (msg) => {
			let msgDate = mDate(msg.time).getDate();
	if (lastDate != msgDate) {
		addDateToMessageArea(msgDate);
		lastDate = msgDate;
	}

	let htmlForGroup = `
	<div class="small font-weight-bold text-primary">
		${contactList.find(contact => contact.id === msg.sender).number}
	</div>
	`;

	let sendStatus = `<i class="${msg.status < 2 ? "far" : "fas"} fa-check-circle"></i>`;

	DOM.messages.innerHTML += `
	<div class="align-self-${msg.sender === user.id ? "end self" : "start"} p-1 my-1 mx-3 rounded bg-white shadow-sm message-item">
		${chat.isGroup ? htmlForGroup : ""}
		<div class="d-flex flex-row">
			<div class="body m-1 mr-2"><a href="/whatsApp/DownLoadFile/${msg.id}" style="text-decoration: none; color: ${msg.body !== msg.fileName ? "black" : "blue"};">${msg.body}</a></div>
			
			<div class="time ml-auto small text-right flex-shrink-0 align-self-end text-muted" style="width:75px;">
				
				${(msg.sender === user.id) ? sendStatus : ""}
			</div>
		</div>
	</div>
	`;

	DOM.messages.scrollTo(0, DOM.messages.scrollHeight);
};

let generateMessageArea = (elem, chatIndex) => {
	chat = chatList[chatIndex];

	mClassList(DOM.inputArea).contains("d-none", (elem) => elem.remove("d-none").add("d-flex"));
	mClassList(DOM.messageAreaOverlay).add("d-none");

	[...DOM.chatListItem].forEach((elem) => mClassList(elem).remove("active"));

	mClassList(elem).contains("unread", () => {
		 MessageUtils.changeStatusById({
			isGroup: chat.isGroup,
			id: chat.isGroup ? chat.group.id : chat.contact.id
		});
		mClassList(elem).remove("unread");
		mClassList(elem.querySelector("#unread-count")).add("d-none");
	});

	if (window.innerWidth <= 575) {
		mClassList(DOM.chatListArea).remove("d-flex").add("d-none");
		mClassList(DOM.messageArea).remove("d-none").add("d-flex");
		areaSwapped = true;
	} else {
		mClassList(elem).add("active");
	}

	DOM.messageAreaName.innerHTML = chat.name;
	DOM.messageAreaPic.src = chat.isGroup ? "/"+ "Content/Whatsappimages/Ass09123asdj9dk0qw.jpg" : "/"+ "Content/Whatsappimages/Ass09123asdj9dk0qw.jpg";
//chat.contact.pic.
	// Message Area details ("last seen ..." for contacts / "..names.." for groups)
	if (chat.isGroup) {
		let groupMembers = groupList.find(group => group.id === chat.group.id).members;
		let memberNames = contactList
				.filter(contact => groupMembers.indexOf(contact.id) !== -1)
				.map(contact => contact.id === user.id ? "You" : contact.name)
				.join(", ");
		
		DOM.messageAreaDetails.innerHTML = `${memberNames}`;
	} else {
		DOM.messageAreaDetails.innerHTML = `last seen ${mDate(chat.contact.lastSeen).lastSeenFormat()}`;
	}

	let msgs = chat.isGroup ? MessageUtils.getByGroupId(chat.group.id) : MessageUtils.getByContactId(chat.contact.id);

	DOM.messages.innerHTML = "";

	lastDate = "";
	msgs
	.sort((a, b) => mDate(a.time).subtract(b.time))
	.forEach((msg) => addMessageToMessageArea(msg));
};

let showChatList = () => {
	if (areaSwapped) {
		mClassList(DOM.chatListArea).remove("d-none").add("d-flex");
		mClassList(DOM.messageArea).remove("d-flex").add("d-none");
		areaSwapped = false;
	}
};


let sendMessage = () => {
	let value = DOM.messageInput.value;
	DOM.messageInput.value = "";
	if (value === "") return;

	let msg = {
		sender: user.id,
		body: value,
		time: mDate().toString(),
		status: 1,
		recvId: chat.isGroup ? chat.group.id : chat.contact.id,
		recvIsGroup: chat.isGroup
	};

	$.ajax({
		type: "POST",
		url: "/whatsApp/addMessage",
		data: JSON.stringify(msg),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (r) {
			console.log(r);
		}
	});

	addMessageToMessageArea(msg);
	MessageUtils.addMessage(msg);
	generateChatList();
};

let sendFile = () => {

// Checking whether FormData is available in browser  
if (window.FormData !== undefined) {  
  
var fileUpload = $("#postedFile").get(0);  
var files = fileUpload.files;  
			  
		// Create FormData object  
		var fileData = new FormData();  
  
		// Looping over all files and add it to FormData object  
		for (var i = 0; i < files.length; i++) {  
			fileData.append(files[i].name, files[i]);  
		} 

// Adding one more key to FormData object  
//  fileData.append('username', �Manas�);  

$.ajax({  
	url: '/whatsApp/FileUpload',  
	type: "POST",  
	contentType: false, // Not to set any content header  
	processData: false, // Not to process data  
	data: fileData,  
	success: function (result) {  
		console.log(result);  
		console.log(fileData);
		console.log(files);
	},  
	error: function (err) {  
		console.log(err.statusText);  
	}  
});


} else {  
	console.log("FormData is not supported.");  
}

	let ms = {
		sender: user.id,
		body: files[0].name,
		time: mDate().toString(),
		status: 1,
		recvId: chat.isGroup ? chat.group.id : chat.contact.id,
		recvIsGroup: chat.isGroup
	};

	$.ajax({
		type: "POST",
		url: "/whatsApp/addFileMessage",
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(ms),
		success: function (result) {
			console.log(result);
			//console.log(files);
		},
		error: function (status) {
			console.log(status);
		}
	});
	
	addMessageToMessageArea(ms);
	MessageUtils.addMessage(ms); 
	generateChatList();

/*let file = $("#postedFile").get(0).files[0];
var r;
var reader = new FileReader();

console.log('EMPTY', reader.readyState);

reader.readAsText(file);
console.log('LOADING', reader.readyState);

reader.onloadend = function (evt) {
	console.log('DONE', reader.readyState);
	console.log(evt.target.result);
	r = JSON.parse(evt.target.result);
	console.log(r);
};

let ms = {
	sender: user.id,
	body:r ,
	time: mDate().toString(),
	status: 1,
	recvId: chat.isGroup ? chat.group.id : chat.contact.id,
	recvIsGroup: chat.isGroup,
	//fileData: ,
	fileName: file.name,
	fileType: file.type
};

	$.ajax({
		type: "POST",
		url: "/whatsApp/UploadFile",
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(ms),
		success: function (result) {
			console.log(result);
			console.log(file);
		},
		error: function (status) {
			console.log(status);
		}
	});
	*/

	
};

let showProfileSettings = () => {
	DOM.profileSettings.style.left = 0;
	DOM.profilePic.src = "/"+ user.pic;
	DOM.inputName.value = user.name;
};

let hideProfileSettings = () => {
	DOM.profileSettings.style.left = "-110%";
	DOM.username.innerHTML = user.name;
};

window.addEventListener("resize", e => {
	if (window.innerWidth > 575) showChatList();
});

let init = () => {
	DOM.username.innerHTML = "";
DOM.displayPic.src = "/Content/Whatsappimages/Ass09123asdj9dk0qw.jpg";
DOM.profilePic.stc = "/Content/Whatsappimages/Ass09123asdj9dk0qw.jpg";
	DOM.profilePic.addEventListener("click", () => DOM.profilePicInput.click());
	DOM.profilePicInput.addEventListener("change", () => console.log(DOM.profilePicInput.files[0]));
	DOM.inputName.addEventListener("blur", (e) => user.name = e.target.value);
	generateChatList();

	console.log("Click the Image at top-left to open settings.");
};

	init();

