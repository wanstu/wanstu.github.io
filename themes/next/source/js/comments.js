/* global CONFIG */
document.onkeydown = function(e) {
  // https://javascript.info/keyboard-events
  if (e.ctrlKey && e.code == "KeyF") {
      document.querySelector("i.fa.fa-search.fa-fw").click();
      e.preventDefault();
  }
};

window.addEventListener('tabs:register', () => {
  let { activeClass } = CONFIG.comments;
  if (CONFIG.comments.storage) {
    activeClass = localStorage.getItem('comments_active') || activeClass;
  }
  if (activeClass) {
    const activeTab = document.querySelector(`a[href="#comment-${activeClass}"]`);
    if (activeTab) {
      activeTab.click();
    }
  }
});
if (CONFIG.comments.storage) {
  window.addEventListener('tabs:click', event => {
    if (!event.target.matches('.tabs-comment .tab-content .tab-pane')) return;
    const commentClass = event.target.classList[1];
    localStorage.setItem('comments_active', commentClass);
  });
}
