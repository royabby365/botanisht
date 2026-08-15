#!/usr/bin/env python3
"""Expand Botanisht plant catalog from 73 -> 121 plants.

Appends curated entries (herbs/veg, houseplants, pollinator flowers) using the
existing JSON:API schema. Companion/antagonist names cross-reference existing
catalog entries (and other new entries) so Companion Alerts resolve by name.
"""
import json
from collections import Counter

CATALOG = 'assets/data/plant_catalog.json'

with open(CATALOG) as f:
    plants = json.load(f)

existing_names = {p['attributes']['name'] for p in plants}
existing_lower = {n.lower(): n for n in existing_names}
print('before:', len(plants))

def ent(name, sci, desc, sun, water, pet, category,
        companions=None, antagonists=None, days=None, prop='Seed',
        spacing=None, row=None, depth=None):
    # normalize companion names to exact existing/new spellings
    def norm(names):
        out = []
        for n in names:
            hit = existing_lower.get(n.lower())
            out.append(hit if hit else n)
        return out
    return {
        'id': _id(),
        'type': 'crops',
        'attributes': {
            'name': name,
            'scientific_name': sci,
            'photo_url': f'https://placehold.co/200x200/1B4332/F5F0E1?text={name.replace(" ", "+")}',
            'description': desc,
            'sun_requirements': sun,
            'water_requirements': water,
            'pet_safe': pet,
            'category': category,
            **({'companions': norm(companions)} if companions else {}),
            **({'antagonists': norm(antagonists)} if antagonists else {}),
            **({'days_to_harvest': days} if days else {}),
            'propagation': prop,
            **({'spacing': spacing} if spacing else {}),
            **({'row_spacing': row} if row else {}),
            **({'seed_depth': depth} if depth else {}),
        },
    }

_ids = iter(range(300, 400))
def _id():
    return next(_ids)

new = [
    # ---- Kitchen / vegetables & herbs (15) ----
    ent('Arugula', 'Eruca vesicaria', 'Peppery salad green that bolts fast in heat; sow in cool weather for the best flavor.',
        ['Full sun', 'Partial shade'], ['Moderate'], True, 'kitchen',
        companions=['Lettuce', 'Spinach', 'Dill'], antagonists=['Strawberry'],
        days=40, spacing='6 in', row='12 in', depth='0.25 in'),
    ent('Beets', 'Beta vulgaris', 'Sweet, earthy root crop; both roots and tops are edible and packed with nutrients.',
        ['Full sun', 'Partial shade'], ['Moderate'], True, 'kitchen',
        companions=['Onion', 'Garlic', 'Lettuce', 'Mint'], antagonists=['Green Beans'],
        days=55, spacing='3 in', row='12 in', depth='0.5 in'),
    ent('Bok Choy', 'Brassica rapa subsp. chinensis', 'Fast-growing Asian green with crisp stalks; harvest whole heads or leaf-by-leaf.',
        ['Full sun', 'Partial shade'], ['High'], True, 'kitchen',
        companions=['Peas', 'Lettuce', 'Onion'], antagonists=['Strawberry'],
        days=45, spacing='8 in', row='12 in', depth='0.25 in'),
    ent('Brussels Sprouts', 'Brassica oleracea var. gemmifera', 'Slow-growing cool-season crop that forms dense buttons up the stalk.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Thyme', 'Onion', 'Garlic'], antagonists=['Strawberry'],
        days=90, spacing='24 in', row='30 in', depth='0.5 in'),
    ent('Collard Greens', 'Brassica oleracea var. viridis', 'Hardy Southern staple; sweeter after a light frost and very cold tolerant.',
        ['Full sun', 'Partial shade'], ['Moderate'], True, 'kitchen',
        companions=['Onion', 'Garlic', 'Rosemary'], antagonists=['Strawberry'],
        days=60, spacing='18 in', row='24 in', depth='0.5 in'),
    ent('Endive', 'Cichorium endivia', 'Slightly bitter salad green with frilly leaves; blanch heads for milder flavor.',
        ['Full sun', 'Partial shade'], ['Moderate'], True, 'kitchen',
        companions=['Onion', 'Carrot'], antagonists=[],
        days=50, spacing='10 in', row='18 in', depth='0.25 in'),
    ent('Fennel', 'Foeniculum vulgare', 'Aromatic bulb and feathery fronds; strong flavor that does not play well with many neighbors.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=[], antagonists=['Tomato', 'Green Beans', 'Dill', 'Cilantro'],
        days=80, spacing='10 in', row='18 in', depth='0.25 in'),
    ent('Ginger', 'Zingiber officinale', 'Tropical rhizome grown for its spicy root; thrives in warm, humid, partially shaded spots.',
        ['Partial shade'], ['High'], True, 'kitchen',
        companions=['Lettuce', 'Peas', 'Spinach'], antagonists=[],
        days=250, prop='Rhizome division'),
    ent('Kohlrabi', 'Brassica oleracea var. gongylodes', 'Quirky above-ground bulb with a mild turnip-cabbage flavor; grows fast.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Onion', 'Celery'], antagonists=['Strawberry'],
        days=55, spacing='6 in', row='18 in', depth='0.5 in'),
    ent('Leeks', 'Allium porrum', 'Mild, sweet onion relative; blanched stems are a classic soup base.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Carrot', 'Celery', 'Onion'], antagonists=['Peas', 'Green Beans'],
        days=120, spacing='6 in', row='12 in', depth='0.5 in'),
    ent('Okra', 'Abelmoschus esculentus', 'Heat-loving Southern pod crop; tall plants with beautiful hibiscus-like flowers.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Eggplant', 'Bell Pepper', 'Basil'], antagonists=[],
        days=60, spacing='12 in', row='36 in', depth='1 in'),
    ent('Parsnip', 'Pastinaca sativa', 'Sweet, nutty winter root; flavor improves after frost exposure.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Peas', 'Onion'], antagonists=['Carrot'],
        days=120, spacing='4 in', row='18 in', depth='0.5 in'),
    ent('Shallots', 'Allium cepa var. aggregatum', 'Gourmet multiplier onion with a delicate garlic-onion balance.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Carrot', 'Strawberry', 'Lettuce'], antagonists=['Peas', 'Green Beans'],
        days=90, prop='Bulb sets'),
    ent('Sorrel', 'Rumex acetosa', 'Zesty, lemony perennial green; a handful of leaves brightens salads and soups.',
        ['Full sun', 'Partial shade'], ['Moderate'], True, 'kitchen',
        companions=['Strawberry', 'Blueberry'], antagonists=[],
        days=60, prop='Division'),
    ent('Turnip', 'Brassica rapa subsp. rapa', 'Fast, reliable root crop; both the bulb and the greens are edible.',
        ['Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Peas', 'Onion', 'Mint'], antagonists=['Potato'],
        days=50, spacing='4 in', row='14 in', depth='0.5 in'),

    # ---- Herbs round 2 (8) ----
    ent('Anise', 'Pimpinella anisum', 'Licorice-scented annual herb; seeds are the prize, fronds are a garnish.',
        ['Full sun'], ['Low'], True, 'kitchen',
        companions=['Cilantro'], antagonists=['Carrot'],
        days=90, spacing='6 in', row='12 in', depth='0.25 in'),
    ent('Lemon Balm', 'Melissa officinalis', 'Lemon-scented mint relative that soothes teas and attracts bees.',
        ['Partial shade', 'Full sun'], ['Moderate'], True, 'kitchen',
        companions=['Tomato', 'Zucchini'], antagonists=[],
        days=70, prop='Division'),
    ent('Catnip', 'Nepeta cataria', 'Mint-family herb that drives cats wild and repels some garden pests.',
        ['Full sun', 'Partial shade'], ['Low'], True, 'kitchen',
        companions=['Tomato', 'Zucchini', 'Peas'], antagonists=[],
        days=75, prop='Division'),
    ent('Winter Savory', 'Satureja montana', 'Hardy perennial savory with a peppery thyme-like flavor; bee magnet.',
        ['Full sun'], ['Low'], True, 'kitchen',
        companions=['Onion', 'Garlic', 'Green Beans'], antagonists=[],
        days=70, prop='Stem cuttings'),
    ent('Sweet Marjoram', 'Origanum majorana', 'Sweet, floral cousin of oregano; a tender perennial for pots and borders.',
        ['Full sun'], ['Low'], True, 'kitchen',
        companions=['Basil', 'Tomato', 'Oregano'], antagonists=[],
        days=80, prop='Stem cuttings'),
    ent('Stevia', 'Stevia rebaudiana', 'Naturally sweet zero-calorie herb; one leaf sweetens a whole cup of tea.',
        ['Full sun', 'Partial shade'], ['Moderate'], True, 'kitchen',
        companions=['Basil', 'Mint'], antagonists=[],
        days=90, prop='Stem cuttings'),
    ent('Horseradish', 'Armoracia rusticana', 'Fierce perennial root that adds heat to sauces; very easy, very vigorous.',
        ['Full sun', 'Partial shade'], ['Moderate'], True, 'kitchen',
        companions=['Potato', 'Zucchini'], antagonists=[],
        days=140, prop='Root division'),
    ent('Chamomile', 'Matricaria chamomilla', 'Cottage-garden herb with apple-scented daisy flowers for calming tea.',
        ['Full sun'], ['Low'], True, 'kitchen',
        companions=['Basil', 'Mint', 'Onion', 'Cabbage'], antagonists=[],
        days=60, spacing='6 in', row='12 in', depth='0.1 in'),

    # ---- Indoor houseplants (10) ----
    ent('Areca Palm', 'Dypsis lutescens', 'Feathery, air-purifying palm that brightens any corner; easy and forgiving.',
        ['Partial shade'], ['Moderate'], True, 'indoor', prop='Division'),
    ent('Boston Fern', 'Nephrolepis exaltata', 'Classic cascading fern that loves humidity; perfect for bathrooms.',
        ['Partial shade'], ['High'], True, 'indoor', prop='Division'),
    ent('Calathea', 'Goeppertia orbifolia', 'Striking striped foliage that folds up at night; a humidity-loving showpiece.',
        ['Partial shade', 'Full shade'], ['High'], True, 'indoor', prop='Division'),
    ent('Chinese Evergreen', 'Aglaonema commutatum', 'Tough, low-light survivor with silver-speckled leaves.',
        ['Partial shade', 'Full shade'], ['Low'], False, 'indoor', prop='Stem cuttings'),
    ent('Christmas Cactus', 'Schlumbergera truncata', 'Blooms indoors in winter with bright tubular flowers; easy succulent-like care.',
        ['Partial shade'], ['Moderate'], True, 'indoor', prop='Stem cuttings'),
    ent('Dracaena', 'Dracaena marginata', 'Architectural spiky plant that thrives on neglect; great for offices.',
        ['Partial shade'], ['Low'], False, 'indoor', prop='Stem cuttings'),
    ent('Parlor Palm', 'Chamaedorea elegans', 'Victorian favorite that tolerates low light and dry air remarkably well.',
        ['Partial shade'], ['Moderate'], True, 'indoor', prop='Division'),
    ent('Philodendron', 'Philodendron hederaceum', 'Trailing heart-leaf vine that grows almost anywhere; beginner proof.',
        ['Partial shade'], ['Moderate'], False, 'indoor', prop='Stem cuttings'),
    ent('Prayer Plant', 'Maranta leuconeura', 'Leaves fold up like praying hands at night; patterned green and red veins.',
        ['Partial shade'], ['High'], True, 'indoor', prop='Division'),
    ent('Sago Palm', 'Cycas revoluta', 'Primitive, sculptural cycad with stiff feathery fronds; slow but stunning.',
        ['Full sun', 'Partial shade'], ['Low'], False, 'indoor', prop='Offsets'),

    # ---- Pollinator flowers (15) ----
    ent('Agastache', 'Agastache foeniculum', 'Anise-scented bee magnet with purple flower spikes all summer.',
        ['Full sun'], ['Low'], True, 'pollinator', prop='Division'),
    ent("Bachelor's Button", 'Centaurea cyanus', 'Charming old-fashioned blue cornflower that self-seeds happily.',
        ['Full sun'], ['Low'], True, 'pollinator', spacing='8 in'),
    ent('Borage', 'Borago officinalis', 'Blue star flowers beloved by bees; edible blooms taste like cucumber.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Tomato', 'Strawberry', 'Zucchini', 'Pumpkin'], antagonists=[]),
    ent('Butterfly Weed', 'Asclepias tuberosa', 'Vibrant orange milkweed that monarch caterpillars depend on.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Bee Balm', 'Coneflower', 'Black-Eyed Susan'], antagonists=[]),
    ent('Calendula', 'Calendula officinalis', 'Edible marigold-like blooms; petals are a classic salad garnish.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Tomato', 'Basil', 'Cucumber', 'Marigold'], antagonists=[]),
    ent('Columbine', 'Aquilegia canadensis', 'Delicate spurred flowers that hummingbirds adore; self-sows gently.',
        ['Partial shade', 'Full sun'], ['Moderate'], True, 'pollinator',
        companions=['Coneflower', 'Bee Balm'], antagonists=[]),
    ent('Foxglove', 'Digitalis purpurea', 'Towering spires of tubular blooms; stunning but toxic if ingested.',
        ['Partial shade', 'Full sun'], ['Moderate'], False, 'pollinator',
        companions=['Snapdragon', 'Hollyhock'], antagonists=[]),
    ent('Gaillardia', 'Gaillardia pulchella', 'Firewheel daisies in red and gold that bloom nonstop in poor soil.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Coneflower', 'Black-Eyed Susan'], antagonists=[]),
    ent('Hollyhock', 'Alcea rosea', 'Old-fashioned cottage spires reaching 6 ft; a backdrop plant for borders.',
        ['Full sun'], ['Moderate'], True, 'pollinator',
        companions=['Foxglove', 'Snapdragon'], antagonists=[]),
    ent('Lupine', 'Lupinus perennis', 'Pea-like flower spikes in blue and purple; fixes nitrogen in the soil.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Coneflower', 'Bee Balm'], antagonists=[]),
    ent('Milkweed', 'Asclepias syriaca', 'Common milkweed — the essential monarch host plant with fragrant blooms.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Bee Balm', 'Coneflower', 'Black-Eyed Susan'], antagonists=[]),
    ent('Nasturtium', 'Tropaeolum majus', 'Peppery edible flowers and leaves; traps aphids away from veggies.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Cucumber', 'Tomato', 'Radish', 'Zucchini'], antagonists=[]),
    ent('Snapdragon', 'Antirrhinum majus', 'Tall, colorful spikes that snap open like dragon mouths; great cut flowers.',
        ['Full sun'], ['Moderate'], True, 'pollinator',
        companions=['Hollyhock', 'Foxglove', 'Calendula'], antagonists=[]),
    ent('Sweet Alyssum', 'Lobularia maritima', 'Frothy white honey-scented carpet that draws hoverflies and bees.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Tomato', 'Basil', 'Lettuce', 'Marigold'], antagonists=[]),
    ent('Yarrow', 'Achillea millefolium', 'Ferny, flat-topped clusters in many colors; a pollinator powerhouse.',
        ['Full sun'], ['Low'], True, 'pollinator',
        companions=['Coneflower', 'Bee Balm', 'Lavender', 'Rosemary'], antagonists=[]),
]

# sanity: no duplicate names with existing catalog
for e in new:
    assert e['attributes']['name'] not in existing_names, e['attributes']['name']
    existing_names.add(e['attributes']['name'])

# Normalize pre-existing generic companion refs to exact catalog names so
# Companion Alerts resolve. Unmappable generics (no catalog match) are left as-is.
NORM = {
    'Bean': 'Green Beans', 'Pea': 'Peas', 'Pepper': 'Bell Pepper',
    'Squash': 'Zucchini', 'Rose': 'Knock Out Rose', 'Echinacea': 'Coneflower',
    'Alyssum': 'Sweet Alyssum', 'Marjoram': 'Sweet Marjoram',
    'Beet': 'Beets', 'Apple': 'Dwarf Apple',
}
for p in plants:
    for key in ('companions', 'antagonists'):
        refs = p['attributes'].get(key)
        if refs:
            p['attributes'][key] = [NORM.get(r, r) for r in refs]

plants.extend(new)
with open(CATALOG, 'w') as f:
    json.dump(plants, f, indent=2, ensure_ascii=False)

print('after:', len(plants))
print('new ids:', min(e['id'] for e in new), '-', max(e['id'] for e in new))
print('categories:', dict(Counter(p['attributes']['category'] for p in plants)))

# verify all companion refs resolve to catalog names
names = {p['attributes']['name'] for p in plants}
unresolved = set()
for p in plants:
    for key in ('companions', 'antagonists'):
        for n in p['attributes'].get(key, []):
            if n not in names:
                unresolved.add(f"{p['attributes']['name']} -> {n}")
print('unresolved refs:', unresolved if unresolved else 'none')
