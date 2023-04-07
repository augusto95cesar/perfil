// setTimeout(() => {
//     (function () {
//         var delay = 3000;        

//         var label = document.getElementById("#label");
//         var value = parseInt(label.textContent);

//         var progress = document.getElementById("#progress");

//         var resumeBtn = document.getElementById("#resume");
//         var pauseBtn = document.getElementById("#pause");
//         var resetBtn = document.getElementById("#reset");

//         var t = new timer(function () {
//           label.textContent = ++value;
//         }, delay);

//         progress.style.animationDuration = delay + "ms";

//         resumeBtn.addEventListener("click", function () {
//           t.resume();

//           pauseBtn.classList.remove("disabled");
//           resumeBtn.classList.add("disabled");
//           resetBtn.classList.add("disabled");

//           progress.classList.add("animate");
//           progress.classList.remove("pause");
//         });

//         pauseBtn.addEventListener("click", function () {
//           t.pause();

//           pauseBtn.classList.add("disabled");
//           resumeBtn.classList.remove("disabled");
//           resetBtn.classList.remove("disabled");

//           progress.classList.add("pause");
//         });

//         resetBtn.addEventListener("click", function () {
//           t.reset();

//           pauseBtn.classList.add("disabled");
//           resumeBtn.classList.remove("disabled");
//           resetBtn.classList.add("disabled");

//           // https://css-tricks.com/restart-css-animation/
//           progress.classList.remove("animate");
//           void progress.offsetWidth;
//           progress.classList.add("animate");
//         });
//       })();

//       function timer(callback, delay) {
//         var timerId;
//         var start;
//         var remaining = delay;

//         this.pause = function () {
//           window.clearTimeout(timerId);
//           remaining -= new Date() - start;
//         };

//         var resume = function () {
//           start = new Date();
//           timerId = window.setTimeout(function () {
//             remaining = delay;
//             resume();
//             callback();
//           }, remaining);
//         };
//         this.resume = resume;

//         this.reset = function () {
//           remaining = delay;
//         };
//       }
// }, 1000)

setTimeout(() => {
    time()
}, 200)

time = () => {
    loop = 0
    init = () => {
        tempo = setInterval(() => {
            html = `<p>${loop}</p>
                <button id='pause'>Pause</button>
                <button id='start'>Start</button>
            `

            document.body.innerHTML = html
            var pause = document.getElementById('pause')
            pause.addEventListener('click', () => {
                clearInterval(tempo)
            })
            var start = document.getElementById('start')
            start.addEventListener('click', () => {
                init()
            })
            loop++
        }, 1000)
    }   
    init()   
}

var result = `<tr role="row">
<td colspan="1" id="categoria-${l}`