<div class="CodeRay">
  <div class="code"><pre><span class="line-numbers"> <a href="#n1" name="n1">1</a></span><span style="color:#070">&lt;script</span> <span style="color:#b48">type</span>=<span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">&quot;</span><span style="color:#D20">text/javascript</span><span style="color:#710">&quot;</span></span><span style="color:#070">&gt;</span>
<span class="line-numbers"> <a href="#n2" name="n2">2</a></span><span style="background-color:hsla(0,0%,0%,0.07);color:black">        <span style="color:#369;font-weight:bold">$</span>(document).ready(<span style="color:#080;font-weight:bold">function</span>(){</span>
<span class="line-numbers"> <a href="#n3" name="n3">3</a></span><span style="background-color:hsla(0,0%,0%,0.07);color:black">                alert(<span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">&quot;</span><span style="color:#D20">Hello World! Here I am</span><span style="color:#710">&quot;</span></span>);</span>
<span class="line-numbers"> <a href="#n4" name="n4">4</a></span><span style="background-color:hsla(0,0%,0%,0.07);color:black">          });</span>
<span class="line-numbers"> <a href="#n5" name="n5">5</a></span><span style="color:#070">&lt;/script&gt;</span>
<span class="line-numbers"> <a href="#n6" name="n6">6</a></span><span style="color:#777">// Generate the table of contents for a page, using the jQuery</span>
<span class="line-numbers"> <a href="#n7" name="n7">7</a></span><span style="color:#777">// TOC plugin.</span>
<span class="line-numbers"> <a href="#n8" name="n8">8</a></span><span style="color:#777">//</span>
<span class="line-numbers"> <a href="#n9" name="n9">9</a></span><span style="color:#777">// Parameters:</span>
<span class="line-numbers"><strong><a href="#n10" name="n10">10</a></strong></span><span style="color:#777">//</span>
<span class="line-numbers"><a href="#n11" name="n11">11</a></span><span style="color:#777">// insertBefore: selector for jQuery element before which to insert TOC &lt;div&gt;.</span>
<span class="line-numbers"><a href="#n12" name="n12">12</a></span><span style="color:#777">//               The first matching element is used.</span>
<span class="line-numbers"><a href="#n13" name="n13">13</a></span><span style="color:#777">// heading:      heading, if any</span>
<span class="line-numbers"><a href="#n14" name="n14">14</a></span>
<span class="line-numbers"><a href="#n15" name="n15">15</a></span><span style="color:#080;font-weight:bold">function</span> <span style="color:#06B;font-weight:bold">generateTOC</span>(insertBefore, heading) {
<span class="line-numbers"><a href="#n16" name="n16">16</a></span>  <span style="color:#080;font-weight:bold">var</span> container = jQuery(<span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">&quot;</span><span style="color:#D20">&lt;div id='tocBlock'&gt;&lt;/div&gt;</span><span style="color:#710">&quot;</span></span>);
<span class="line-numbers"><a href="#n17" name="n17">17</a></span>  <span style="color:#080;font-weight:bold">var</span> div = jQuery(<span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">&quot;</span><span style="color:#D20">&lt;ul id='toc'&gt;&lt;/ul&gt;</span><span style="color:#710">&quot;</span></span>);
<span class="line-numbers"><a href="#n18" name="n18">18</a></span>  <span style="color:#080;font-weight:bold">var</span> content = jQuery(insertBefore).first();
<span class="line-numbers"><a href="#n19" name="n19">19</a></span>
<span class="line-numbers"><strong><a href="#n20" name="n20">20</a></strong></span>  <span style="color:#080;font-weight:bold">if</span> (heading != <span style="color:#069">undefined</span> &amp;&amp; heading != <span style="color:#069">null</span>) {
<span class="line-numbers"><a href="#n21" name="n21">21</a></span>    container.append(<span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">'</span><span style="color:#D20">&lt;span class=&quot;tocHeading&quot;&gt;</span><span style="color:#710">'</span></span> + heading + <span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">'</span><span style="color:#D20">&lt;/span&gt;</span><span style="color:#710">'</span></span>);
<span class="line-numbers"><a href="#n22" name="n22">22</a></span>  }
<span class="line-numbers"><a href="#n23" name="n23">23</a></span>
<span class="line-numbers"><a href="#n24" name="n24">24</a></span>  div.tableOfContents(content);
<span class="line-numbers"><a href="#n25" name="n25">25</a></span>  container.append(div);
<span class="line-numbers"><a href="#n26" name="n26">26</a></span>  container.insertBefore(insertBefore);
<span class="line-numbers"><a href="#n27" name="n27">27</a></span>}
<span class="line-numbers"><a href="#n28" name="n28">28</a></span><span style="color:#777">/* ===================================================</span>
<span class="line-numbers"><a href="#n29" name="n29">29</a></span><span style="color:#777"> * bootstrap-transition.js v2.3.1</span>
<span class="line-numbers"><strong><a href="#n30" name="n30">30</a></strong></span><span style="color:#777"> * http://twitter.github.com/bootstrap/javascript.html#transitions</span>
<span class="line-numbers"><a href="#n31" name="n31">31</a></span><span style="color:#777"> * ===================================================</span>
<span class="line-numbers"><a href="#n32" name="n32">32</a></span><span style="color:#777"> * Copyright 2012 Twitter, Inc.</span>
<span class="line-numbers"><a href="#n33" name="n33">33</a></span><span style="color:#777"> *</span>
<span class="line-numbers"><a href="#n34" name="n34">34</a></span><span style="color:#777"> * Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);</span>
<span class="line-numbers"><a href="#n35" name="n35">35</a></span><span style="color:#777"> * you may not use this file except in compliance with the License.</span>
<span class="line-numbers"><a href="#n36" name="n36">36</a></span><span style="color:#777"> * You may obtain a copy of the License at</span>
<span class="line-numbers"><a href="#n37" name="n37">37</a></span><span style="color:#777"> *</span>
<span class="line-numbers"><a href="#n38" name="n38">38</a></span><span style="color:#777"> * http://www.apache.org/licenses/LICENSE-2.0</span>
<span class="line-numbers"><a href="#n39" name="n39">39</a></span><span style="color:#777"> *</span>
<span class="line-numbers"><strong><a href="#n40" name="n40">40</a></strong></span><span style="color:#777"> * Unless required by applicable law or agreed to in writing, software</span>
<span class="line-numbers"><a href="#n41" name="n41">41</a></span><span style="color:#777"> * distributed under the License is distributed on an &quot;AS IS&quot; BASIS,</span>
<span class="line-numbers"><a href="#n42" name="n42">42</a></span><span style="color:#777"> * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.</span>
<span class="line-numbers"><a href="#n43" name="n43">43</a></span><span style="color:#777"> * See the License for the specific language governing permissions and</span>
<span class="line-numbers"><a href="#n44" name="n44">44</a></span><span style="color:#777"> * limitations under the License.</span>
<span class="line-numbers"><a href="#n45" name="n45">45</a></span><span style="color:#777"> * ========================================================== */</span>
<span class="line-numbers"><a href="#n46" name="n46">46</a></span>
<span class="line-numbers"><a href="#n47" name="n47">47</a></span>
<span class="line-numbers"><a href="#n48" name="n48">48</a></span>!<span style="color:#080;font-weight:bold">function</span> (<span style="color:#369;font-weight:bold">$</span>) {
<span class="line-numbers"><a href="#n49" name="n49">49</a></span>
<span class="line-numbers"><strong><a href="#n50" name="n50">50</a></strong></span>  <span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">&quot;</span><span style="color:#D20">use strict</span><span style="color:#710">&quot;</span></span>; <span style="color:#777">// jshint ;_;</span>
<span class="line-numbers"><a href="#n51" name="n51">51</a></span>
<span class="line-numbers"><a href="#n52" name="n52">52</a></span>
<span class="line-numbers"><a href="#n53" name="n53">53</a></span>  <span style="color:#777">/* CSS TRANSITION SUPPORT (http://www.modernizr.com/)</span>
<span class="line-numbers"><a href="#n54" name="n54">54</a></span><span style="color:#777">   * ======================================================= */</span>
<span class="line-numbers"><a href="#n55" name="n55">55</a></span>
<span class="line-numbers"><a href="#n56" name="n56">56</a></span>  <span style="color:#369;font-weight:bold">$</span>(<span style="color:#080;font-weight:bold">function</span> () {
<span class="line-numbers"><a href="#n57" name="n57">57</a></span>
<span class="line-numbers"><a href="#n58" name="n58">58</a></span>    <span style="color:#369;font-weight:bold">$</span>.support.transition = (<span style="color:#080;font-weight:bold">function</span> () {
<span class="line-numbers"><a href="#n59" name="n59">59</a></span>
<span class="line-numbers"><strong><a href="#n60" name="n60">60</a></strong></span>      <span style="color:#080;font-weight:bold">var</span> transitionEnd = (<span style="color:#080;font-weight:bold">function</span> () {
<span class="line-numbers"><a href="#n61" name="n61">61</a></span>
<span class="line-numbers"><a href="#n62" name="n62">62</a></span>        <span style="color:#080;font-weight:bold">var</span> el = document.createElement(<span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">'</span><span style="color:#D20">bootstrap</span><span style="color:#710">'</span></span>)
<span class="line-numbers"><a href="#n63" name="n63">63</a></span>          , transEndEventNames = {
<span class="line-numbers"><a href="#n64" name="n64">64</a></span>               <span style="color:#606"><span style="color:#404">'</span><span>WebkitTransition</span><span style="color:#404">'</span></span> : <span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">'</span><span style="color:#D20">webkitTransitionEnd</span><span style="color:#710">'</span></span>
<span class="line-numbers"><a href="#n65" name="n65">65</a></span>            ,  <span style="color:#606"><span style="color:#404">'</span><span>MozTransition</span><span style="color:#404">'</span></span>    : <span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">'</span><span style="color:#D20">transitionend</span><span style="color:#710">'</span></span>
<span class="line-numbers"><a href="#n66" name="n66">66</a></span>            ,  <span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">'</span><span style="color:#D20">OTransitio</span></span>
<span class="line-numbers"><a href="#n67" name="n67">67</a></span><span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#D20"></span></span></pre></div>
</div>
