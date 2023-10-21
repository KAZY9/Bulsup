window.addEventListener('DOMContentLoaded', function() {
    const yearSlectElm = document.querySelector('[name="user[birthdate(1i)]"]');
    const monthSelectElm = document.querySelector('[name="user[birthdate(2i)]"]');
    const daySelectElm = document.querySelector('[name="user[birthdate(3i)]"]');

    function updateDaySelect() {
        const month = parseInt(monthSelectElm.value, 10);
        const year = parseInt(yearSlectElm.value, 10);

        if (isNaN(month) || isNaN(year)) {
            return;
        }

        const daysInMonth = new Date(year, month, 0).getDate();

        for (let i = daySelectElm.options.length -1; i > daysInMonth; i--) {
            daySelectElm.remove(i);
        }

        for (let i = daySelectElm.options.length; i <= daysInMonth; i++) {
            const option = document.createElement('option');
            option.value = i;
            option.text = i;
            daySelectElm.add(option);
        }
    }

    if (yearSlectElm && monthSelectElm && daySelectElm) {
        yearSlectElm.addEventListener('change', updateDaySelect);
        monthSelectElm.addEventListener('change', updateDaySelect);
        updateDaySelect();
    }
});