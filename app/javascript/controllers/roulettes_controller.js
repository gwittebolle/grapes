import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="roulettes"
export default class extends Controller {
  static targets = ["canvas"];
  ctx = null;
  spinAngleStart = 0;

  // Get the image files from the avatars directory

  imageFiles = [
    "79454481 (1).jpg",
    "95698491 (1).jpg",
    "112163637.jpg",
    "122270827 (1).jpg",
    "143180473 (1).jpg",
    "143192700.jpg",
    "143889291.jpg",
    "144740857.jpg",
    "144839186.jpg",
    "144999408 (1).jpg",
    "146070486 (1).jpg",
    "146454821.jpg",
    "147248216.png",
    "147303935.jpg",
    "147395753.png",
    "147396100.jpg",
    "147396181.jpg",
    "baslbie5z4didjabavbl.jpg",
    "nhuahc64h2sektvs3f2k.jpg",
    "nzhqezb459juug7s6u2s.jpg",
    "ro7thxrpsqietp59pivy.jpg",
  ]

  // Map the image files to HTML img tags

  options = this.imageFiles.map(file => `/assets/avatars/${file}`);

  startAngle = 0;
  arc = Math.PI / (this.options.length / 2);
  spinTimeout = null;

  spinArcStart = 10;
  spinTime = 0;
  spinTimeTotal = 0;

  connect() {

  }

  loadImage(src) {
    return new Promise((resolve, reject) => {
      const image = new Image();
      image.onload = () => resolve(image);
      image.onerror = reject;
      image.src = src;
    });
  }


  spin() {

    this.startAngle = 0;
    this.arc = Math.PI / (this.options.length / 2);
    this.spinTimeout = null;

    this.spinArcStart = 10;
    this.spinTime = 0;
    this.spinTimeTotal = 0;
    this.spinAngleStart = 10;
    this.spinTime = 0;
    this.spinTimeTotal = 4.91 * 1000;
    this.rotateWheel();
  }

  rotateWheel() {
    this.spinTime += 10;
    console.log(this.spinTime)
    console.log(this.spinTimeTotal)
    if(this.spinTime >= this.spinTimeTotal) {
      this.stopRotateWheel();
      return;
    }
    this.spinAngle = this.spinAngleStart - this.easeOut(this.spinTime, 0, this.spinAngleStart, this.spinTimeTotal);
    this.startAngle += (this.spinAngle * Math.PI / 180);
    this.drawRouletteWheel();
    this.spinTimeout = setTimeout(() => this.rotateWheel(), 30);
}

  stopRotateWheel() {
    clearTimeout(this.spinTimeout);
    // degrees = this.startAngle * 180 / Math.PI + 90;
    // arcd = this.arc * 180 / Math.PI;
    // index = Math.floor((360 - degrees % 360) / arcd);
    this.ctx.save();
    this.ctx.font = 'bold 65px Helvetica, Arial';
    this.text = "Virgile !"

    this.ctx.fillText(this.text, 250 - this.ctx.measureText(this.text).width / 2, 250 + 10);
    this.ctx.restore();
  }


  drawRouletteWheel() {
    const canvas = this.canvasTarget;
    if (canvas.getContext) {
      const outsideRadius = 200;
      const textRadius = 160;
      const insideRadius = 125;

      this.ctx = canvas.getContext("2d");
      this.ctx.clearRect(0, 0, 500, 500);

      this.ctx.strokeStyle = 'rgba(0,0,0,0.7)';
      this.ctx.lineWidth = 0.01;

      for (let i = 0; i < this.options.length; i++) {
        const angle = this.startAngle + i * this.arc;
        this.ctx.fillStyle = "rgba(255, 255, 255, 0.5)";

        this.ctx.beginPath();
        this.ctx.arc(250, 250, outsideRadius, angle, angle + this.arc, false);
        this.ctx.arc(250, 250, insideRadius, angle + this.arc, angle, true);
        this.ctx.stroke();
        this.ctx.fill();

        this.ctx.save();
        this.ctx.shadowOffsetX = -1;
        this.ctx.shadowOffsetY = -1;
        this.ctx.shadowBlur = 0;
        this.ctx.shadowColor = "rgb(220,220,220)";
        this.ctx.fillStyle = "black";
        this.ctx.translate(250 + Math.cos(angle + this.arc / 2) * textRadius,
          250 + Math.sin(angle + this.arc / 2) * textRadius);
        this.ctx.rotate(angle + this.arc / 2 + Math.PI / 2);

        // Draw the image
        const image = new Image();
        image.src = this.options[i];

        // Dessiner un cercle pour servir de masque
        this.ctx.beginPath();
        this.ctx.arc(0, 0, 20, 0, 2 * Math.PI);
        this.ctx.closePath();

        // Clipping path - définir la zone de découpe en tant que cercle
        this.ctx.clip();
        this.ctx.drawImage(image, -40, -40, 80, 80);
        this.ctx.restore();
      }

      // Arrow
      this.ctx.fillStyle = "black";
      this.ctx.beginPath();
      this.ctx.moveTo(250 - 4, 250 - (outsideRadius + 5));
      this.ctx.lineTo(250 + 4, 250 - (outsideRadius + 5));
      this.ctx.lineTo(250 + 4, 250 - (outsideRadius - 5));
      this.ctx.lineTo(250 + 9, 250 - (outsideRadius - 5));
      this.ctx.lineTo(250 + 0, 250 - (outsideRadius - 13));
      this.ctx.lineTo(250 - 9, 250 - (outsideRadius - 5));
      this.ctx.lineTo(250 - 4, 250 - (outsideRadius - 5));
      this.ctx.lineTo(250 - 4, 250 - (outsideRadius + 5));
      this.ctx.fill();
    }
  }


  easeOut(t, b, c, d) {
    var ts = (t/=d)*t;
    var tc = ts*t;
    return b+c*(tc + -3*ts + 3*t);
  }
}
