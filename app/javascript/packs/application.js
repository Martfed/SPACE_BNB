import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initMapbox } from '../plugins/init_mapbox';

import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

const application = Application.start()
const context = require.context("../controllers", true, /.js$/)
application.load(definitionsFromContext(context))


initMapbox();


// anime({
//   targets: '.staggering-grid-demo .el',
//   scale: [
//     {value: .1, easing: 'easeOutSine', duration: 500},
//     {value: 1, easing: 'easeInOutQuad', duration: 1200}
//   ],
//   delay: anime.stagger(200, {grid: [14, 5], from: 'center'})
// });
