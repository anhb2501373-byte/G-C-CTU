(() => {
  const SUPABASE_URL = 'https://vykvwnrriyeogodbjkzw.supabase.co';
  const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_yo8fXrvC8DgiEoLXr8VSQg_3zWyhgNO';
  if (!window.supabase?.createClient) return;

  const db = window.supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);
  window.GOC_CTU_SUPABASE = db;
  window.GOC_CTU_PUBLIC_DATA = { assets: {}, places: [], handbook: [], rooms: [] };

  const esc = (value) => String(value ?? '').replace(/[&<>"']/g, (char) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
  })[char]);

  function status(message, error = false) {
    const node = document.getElementById('cloudDirectoryStatus');
    if (!node) return;
    node.textContent = message;
    node.classList.toggle('text-danger', error);
  }

  function renderPlace(row) {
    const category = row.category || 'Địa điểm';
    const price = row.priceLabel || (row.price == null ? '' : `${Number(row.price).toLocaleString('vi-VN')}đ`);
    const tags = String(row.tags || '').split(/[|,;]/).map((item) => item.trim()).filter(Boolean);
    const image = row.imageUrl || '';
    const isRental = category === 'Nhà trọ';
    return `<div class="col-12 place-item ${isRental ? 'rental-feature-card' : ''}"
      data-place-id="${esc(row.id)}" data-category="${esc(category)}"
      data-distance="${Number(row.distanceKm) || 0}" data-budget="1"
      data-price-min="${Number(row.price) || 0}" data-price-max="${Number(row.price) || 0}"
      data-name="${esc(row.name)}" data-traits="">
      <article class="card h-100 ${isRental ? 'rental-card' : ''}">
        ${image ? `<img class="${isRental ? 'rental-cover' : 'place-thumb'}" src="${esc(image)}" alt="Ảnh ${esc(row.name)}" loading="lazy" onerror="this.style.visibility='hidden'">` : ''}
        <div class="card-body ${isRental ? '' : 'd-flex gap-3'}">
          <div class="flex-grow-1 min-w-0">
            <div class="d-flex justify-content-between gap-2"><h3 class="${isRental ? 'h5' : 'h6'} fw-bold mb-1">${esc(row.name)}</h3>
              <button class="btn btn-sm p-0 favorite-btn" aria-label="Lưu ${esc(row.name)}"><i class="bi bi-heart fs-5"></i></button></div>
            <small class="muted d-block mb-2"><i class="bi bi-geo-alt"></i> ${esc(row.address || 'Chưa cập nhật địa chỉ')}${row.distanceKm == null ? '' : ` · ${Number(row.distanceKm)} km`}</small>
            ${price ? `<div class="${isRental ? 'rental-price' : 'price'} mb-2">${esc(price)}</div>` : ''}
            ${tags.map((tag) => `<span class="tag me-1 mb-1 d-inline-block">${esc(tag)}</span>`).join('')}
            ${row.description ? `<div class="small muted mt-1">${esc(row.description)}</div>` : ''}
            ${isRental && row.phone ? `<div class="rental-phone mt-3"><i class="bi bi-telephone-fill me-2"></i><span>Số điện thoại: ${esc(row.phone)}</span></div>` : ''}
          </div>
        </div>
      </article>
    </div>`;
  }

  function renderDirectory(rows) {
    const list = document.getElementById('placeList');
    if (!list || !rows?.length) return;
    list.innerHTML = rows.map(renderPlace).join('');
    const favoriteKey = 'gocCTUFavoritePlaces_v1';
    let favorites = [];
    try { favorites = JSON.parse(localStorage.getItem(favoriteKey) || '[]'); } catch {}
    list.querySelectorAll('.place-item').forEach((card) => {
      const button = card.querySelector('.favorite-btn');
      const id = card.dataset.placeId;
      const icon = button?.querySelector('i');
      const selected = favorites.includes(id);
      if (selected && icon) {
        icon.classList.replace('bi-heart', 'bi-heart-fill');
        icon.classList.add('text-danger');
      }
      button?.addEventListener('click', () => {
        let saved = [];
        try { saved = JSON.parse(localStorage.getItem(favoriteKey) || '[]'); } catch {}
        const next = new Set(saved);
        if (next.has(id)) next.delete(id); else next.add(id);
        try { localStorage.setItem(favoriteKey, JSON.stringify([...next])); } catch {}
        const active = next.has(id);
        icon?.classList.toggle('bi-heart-fill', active);
        icon?.classList.toggle('bi-heart', !active);
        icon?.classList.toggle('text-danger', active);
      });
    });
    status(`Danh mục địa điểm đang lấy ${rows.length} mục từ Supabase.`);
    document.getElementById('applyFilters')?.click();
  }

  function renderHandbook(rows) {
    if (!rows?.length) return;
    const contentByTitle = new Map();
    rows.forEach((row) => {
      contentByTitle.set(String(row.title || ''), row);
      const entry = [...document.querySelectorAll('#guideAccordion .guide-entry')]
        .find((item) => item.querySelector('strong')?.textContent.trim() === row.title);
      if (!entry) return;
      const summary = entry.querySelector('p');
      if (summary && row.summary) summary.textContent = row.summary;
    });
    window.addEventListener('click', (event) => {
      const button = event.target.closest('#guideAccordion .guide-read');
      if (!button) return;
      const item = contentByTitle.get(button.dataset.title || '');
      if (!item) return;
      event.preventDefault();
      event.stopImmediatePropagation();
      const title = document.getElementById('guideModalTitle');
      const body = document.getElementById('guideModalBody');
      if (title) title.textContent = item.title || 'Cẩm nang CTU';
      if (body) {
        body.textContent = item.content || item.summary || 'Chưa có nội dung.';
        if (item.url && /^https:\/\//i.test(item.url)) {
          const link = document.createElement('a');
          link.href = item.url;
          link.target = '_blank';
          link.rel = 'noopener noreferrer';
          link.textContent = 'Mở nguồn tham khảo';
          link.className = 'd-block mt-3';
          body.append(link);
        }
      }
      if (window.bootstrap) bootstrap.Modal.getOrCreateInstance(document.getElementById('guideModal')).show();
    }, true);
  }

  async function loadPublicContent() {
    const list = document.getElementById('placeList');
    if (list) {
      const label = document.createElement('div');
      label.id = 'cloudDirectoryStatus';
      label.className = 'small muted mb-2';
      label.textContent = 'Đang tải danh mục từ Supabase…';
      list.parentNode?.insertBefore(label, list);
    }

    // Public visitors can browse. Shared content has read-only RLS policies.
    const [assetsResult, placesResult, handbookResult, roomsResult] = await Promise.all([
      db.from('site_assets').select('asset_key, file_name, public_url').eq('is_public', true),
      db.from('places').select('*').order('name'),
      db.from('handbook').select('*').order('title'),
      db.from('rooms').select('*').order('roomCode')
    ]);

    if (assetsResult.data) {
      window.GOC_CTU_PUBLIC_DATA.assets = Object.fromEntries(assetsResult.data.map((row) => [row.asset_key, row.public_url]));
    }
    if (placesResult.data?.length) {
      window.GOC_CTU_PUBLIC_DATA.places = placesResult.data;
      renderDirectory(placesResult.data);
    } else if (placesResult.error) {
      status('Không tải được danh mục trực tuyến; đang hiển thị nội dung có sẵn.', true);
    } else {
      status('Danh mục Supabase chưa có dữ liệu; đang hiển thị nội dung có sẵn.');
    }
    if (handbookResult.data) {
      window.GOC_CTU_PUBLIC_DATA.handbook = handbookResult.data;
      renderHandbook(handbookResult.data);
    }
    if (roomsResult.data) window.GOC_CTU_PUBLIC_DATA.rooms = roomsResult.data;
  }

  // Shared listing edits are made in Supabase Studio, never through an
  // unauthenticated public form.
  document.getElementById('openRentalAdmin')?.remove();
  document.getElementById('rentalAdminModal')?.remove();
  loadPublicContent().catch(() => status('Không kết nối được Supabase; đang hiển thị nội dung có sẵn.', true));
})();
