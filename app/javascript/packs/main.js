/* eslint func-names: ["error", "never"] */

const visibleClass = 'is-visible';
const hiddenClass = 'is-hidden';
const modifiedImageLabel = '.cd-image-label[data-type="modified"]';
const originalImageLabel = '.cd-image-label[data-type="original"]';
const resizeImgClass = '.cd-resize-img';

function checkPosition(container) {
  container.each(function () {
    const actualContainer = $(this);
    if ($(window).scrollTop() + $(window).height() * 0.5 > actualContainer.offset().top) {
      actualContainer.addClass(visibleClass);
    }
  });
}

function updateLabel(label, resizeElement, position) {
  if (position === 'left') {
    if (label.offset().left + label.outerWidth() < resizeElement.offset().left + resizeElement.outerWidth()) {
      label.removeClass(hiddenClass);
    } else {
      label.addClass(hiddenClass);
    }
  } else if (label.offset().left > resizeElement.offset().left + resizeElement.outerWidth()) {
    label.removeClass(hiddenClass);
  } else {
    label.addClass(hiddenClass);
  }
}

// draggable functionality - credits to http://css-tricks.com/snippets/jquery/draggable-without-jquery-ui/
function drags(dragElement, resizeElement, container, labelContainer, labelResizeElement) {
  dragElement.on('mousedown vmousedown touchstart', (e) => {
    dragElement.addClass('draggable');
    resizeElement.addClass('resizable');
    const pageX = e.pageX || e.originalEvent.touches[0].pageX;
    const dragWidth = dragElement.outerWidth();
    const xPosition = dragElement.offset().left + dragWidth - pageX;
    const containerOffset = container.offset().left;
    const containerWidth = container.outerWidth();
    const minLeft = containerOffset + 10;
    const maxLeft = containerOffset + containerWidth - dragWidth - 10;

    dragElement.parents().on('mousemove vmousemove touchmove', (event) => {
      const movePageX = event.pageX || event.originalEvent.touches[0].pageX;
      let leftValue = movePageX + xPosition - dragWidth;

      // constrain the draggable element to move inside his container
      if (leftValue < minLeft) {
        leftValue = minLeft;
      } else if (leftValue > maxLeft) {
        leftValue = maxLeft;
      }

      const widthValue = `${(leftValue + dragWidth / 2 - containerOffset) * 100 / containerWidth}%`;

      $('.draggable').css('left', widthValue).on('mouseup vmouseup touchend', function () {
        $(this).removeClass('draggable');
        resizeElement.removeClass('resizable');
      });

      $('.resizable').css('width', widthValue);

      updateLabel(labelResizeElement, resizeElement, 'left');
      updateLabel(labelContainer, resizeElement, 'right');
    }).on('mouseup vmouseup touchend', () => {
      dragElement.removeClass('draggable');
      resizeElement.removeClass('resizable');
    });
    e.preventDefault();
  }).on('mouseup vmouseup touchend', () => {
    dragElement.removeClass('draggable');
    resizeElement.removeClass('resizable');
  });
}

$(document).on('load turbolinks:load', () => {
  const $container = $('.cd-image-container');
  if (!$container) { return; }
  // check if the .cd-image-container is in the viewport
  // if yes, animate it
  checkPosition($container);
  $(window).on('turbolinks:load', () => {
    checkPosition($container);
  });

  // make the .cd-handle element draggable and modify .cd-resize-img width according to its position
  $container.each(function () {
    const actual = $(this);
    drags(
      actual.find('.cd-handle'),
      actual.find(resizeImgClass),
      actual,
      actual.find(originalImageLabel),
      actual.find(modifiedImageLabel),
    );
  });

  // update images label visibility
  $(window).on('resize', () => {
    $container.each(function () {
      const actual = $(this);
      updateLabel(actual.find(modifiedImageLabel), actual.find(resizeImgClass), 'left');
      updateLabel(actual.find(originalImageLabel), actual.find(resizeImgClass), 'right');
    });
  });
});
