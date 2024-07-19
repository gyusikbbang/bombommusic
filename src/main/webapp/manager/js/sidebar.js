const shrink_btn = document.querySelector(".shrink-btn");
const search = document.querySelector(".search");
const sidebar_links = document.querySelectorAll(".sidebar-links a");
const active_tab = document.querySelector(".active-tab");
const shortcuts = document.querySelector(".sidebar-links h4");
const tooltip_elements = document.querySelectorAll(".tooltip-element");

let activeIndex;









function ViewinsertForm() {
	const insert = document.getElementById('productinsert');
	const main = document.getElementById('info');
	const update = document.getElementById('productupdate');
	const memberlist = document.getElementById('memberList');
	const orderList = document.getElementById('orderList');


	if (main.style.display === 'block') {
		main.style.display = 'none';
	}

	if (update.style.display === 'block') {
		update.style.display = 'none';
	}
	if (memberlist.style.display === 'block') {
		memberlist.style.display = 'none';
	}

	if (insert.style.display === 'none') {
		insert.style.display = 'block';
	}
	if (orderList.style.display === 'block') {
		orderList.style.display  = 'none'
	}
}



function ViewUpdateList() {
	const update = document.getElementById('productupdate');
	const main = document.getElementById('info');
	const insert = document.getElementById('productinsert');
	const orderList = document.getElementById('orderList');
	const memberlist = document.getElementById('memberList');
		
	if (main.style.display === 'block') {
		main.style.display = 'none';
	}

	if (insert.style.display === 'block') {
		insert.style.display = 'none';
	}
	if (memberlist.style.display === 'block') {
		memberlist.style.display = 'none';
	}


	if (update.style.display === 'none') {
		update.style.display = 'block';
	}
	
	if (orderList.style.display === 'block') {
		orderList.style.display  = 'none'
	}
}

function Viewhome() {
	const insert = document.getElementById('productinsert');
	const update = document.getElementById('productupdate');
	const memberlist = document.getElementById('memberList');
const orderList = document.getElementById('orderList');
	const info = document.getElementById('info')


	if (insert.style.display === 'block') {
		insert.style.display = 'none';
	}
	if (update.style.display === 'block') {
		update.style.display = 'none';
	}
	if (memberlist.style.display === 'block') {
		memberlist.style.display = 'none';
	}


	if (info.style.display === 'none') {
		info.style.display = 'block'
	}
}


function ViewMemberList() {
	const insert = document.getElementById('productinsert');
	const update = document.getElementById('productupdate');
	const memberlist = document.getElementById('memberList');
const orderList = document.getElementById('orderList');
	const info = document.getElementById('info')


	if (insert.style.display === 'block') {
		insert.style.display = 'none';
	}
	if (update.style.display === 'block') {
		update.style.display = 'none';
	}
	
	if (info.style.display === 'block') {
		info.style.display = 'none'
	}


	if (orderList.style.display === 'block') {
		orderList.style.display  = 'none'
	}

	if (memberlist.style.display === 'none') {
		memberlist.style.display  = 'block'
	}
}





function VieworderList() {
	const insert = document.getElementById('productinsert');
	const update = document.getElementById('productupdate');
	const memberlist = document.getElementById('memberList');
	const orderList = document.getElementById('orderList');

	const info = document.getElementById('info')


	if (insert.style.display === 'block') {
		insert.style.display = 'none';
	}
	if (update.style.display === 'block') {
		update.style.display = 'none';
	}
	
	if (info.style.display === 'block') {
		info.style.display = 'none'
	}


	if (memberlist.style.display === 'block') {
		memberlist.style.display  = 'none'
	}
	
	
	if (orderList.style.display === 'none') {
		orderList.style.display  = 'block'
	}
	
	
	
	
}



shrink_btn.addEventListener("click", () => {
	document.body.classList.toggle("shrink");
	setTimeout(moveActiveTab, 400);

	shrink_btn.classList.add("hovered");

	setTimeout(() => {
		shrink_btn.classList.remove("hovered");
	}, 500);
});

search.addEventListener("click", () => {
	document.body.classList.remove("shrink");
	search.lastElementChild.focus();
});

function moveActiveTab() {
	let topPosition = activeIndex * 58 + 2.5;

	if (activeIndex > 3) {
		topPosition += shortcuts.clientHeight;
	}

	active_tab.style.top = `${topPosition}px`;
}

function changeLink() {
	sidebar_links.forEach((sideLink) => sideLink.classList.remove("active"));
	this.classList.add("active");

	activeIndex = this.dataset.active;

	moveActiveTab();
}

sidebar_links.forEach((link) => link.addEventListener("click", changeLink));

function showTooltip() {
	let tooltip = this.parentNode.lastElementChild;
	let spans = tooltip.children;
	let tooltipIndex = this.dataset.tooltip;

	Array.from(spans).forEach((sp) => sp.classList.remove("show"));
	spans[tooltipIndex].classList.add("show");

	tooltip.style.top = `${(100 / (spans.length * 2)) * (tooltipIndex * 2 + 1)}%`;
}

tooltip_elements.forEach((elem) => {
	elem.addEventListener("mouseover", showTooltip);
});
